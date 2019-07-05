/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "downloadmanager.h"

#include <QTextStream>
#include <QDebug>
#include <cstdio>

using namespace std;
QString DownloadManager::adsPath="";
DownloadManager::DownloadManager(QObject *parent)
    : QObject(parent)
{
}

void DownloadManager::append(const QStringList &urls)
{
    adsPath = QString("%1/updater").arg(qApp->applicationDirPath());
    for (const QString &urlAsString : urls)
        append(QUrl::fromEncoded(urlAsString.toLocal8Bit()));
    if (downloadQueue.isEmpty())
        QTimer::singleShot(0, this, SIGNAL(finished()));
}

void DownloadManager::append(const QUrl &url)
{
    if (downloadQueue.isEmpty())
        QTimer::singleShot(0, this, SLOT(startNextDownload()));
    downloadQueue.enqueue(url);
    ++totalCount;
}

QString DownloadManager::saveFileName(const QUrl &url)
{
    QString path = url.path();
    QString basename = QFileInfo(path).fileName();

    if (basename.isEmpty())
        basename = "download";

    if (QFile::exists(basename)) {
        // already exists, remove
        //QFile::remove(basename);
//        basename = adsPath+"/"+basename;
//        emit finished(basename);
//        return basename;
    }    
    QDir dir(adsPath);
    if(!dir.exists()){
        dir.mkpath(adsPath);
    }
    basename = adsPath+"/"+basename;
    qDebug()<<Q_FUNC_INFO<<basename;
    return basename;
}

void DownloadManager::startNextDownload()
{
    if (downloadQueue.isEmpty()) {
        emit finished(filename);
        return;
    }

    QUrl url = downloadQueue.dequeue();

    filename = saveFileName(url);
    output.setFileName(filename);
    if (!output.open(QIODevice::WriteOnly)) {
        startNextDownload();
        return;
    }
    QNetworkRequest request(url);
    currentDownload = manager.get(request);
    connect(currentDownload, SIGNAL(downloadProgress(qint64,qint64)),
            SLOT(downloadProgress(qint64,qint64)));
    connect(currentDownload, SIGNAL(finished()),
            SLOT(downloadFinished()));
    connect(currentDownload, SIGNAL(readyRead()),
            SLOT(downloadReadyRead()));

    // prepare the output
    qDebug("Downloading %s...\n", url.toEncoded().constData());
    downloadTime.start();
}

void DownloadManager::downloadProgress(qint64 bytesReceived, qint64 bytesTotal)
{
}

void DownloadManager::downloadFinished()
{
    output.close();
    if (currentDownload->error()) {
        // download failed
        output.remove();
    } else {
        // let's check if it was actually a redirect
        if (isHttpRedirect()) {
            reportRedirect();
            output.remove();
        } else {
            ++downloadedCount;
        }
    }
    currentDownload->deleteLater();
    startNextDownload();
}

void DownloadManager::downloadReadyRead()
{
    output.write(currentDownload->readAll());
}

bool DownloadManager::isHttpRedirect() const
{
    int statusCode = currentDownload->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    return statusCode == 301 || statusCode == 302 || statusCode == 303
           || statusCode == 305 || statusCode == 307 || statusCode == 308;
}

void DownloadManager::reportRedirect()
{
    int statusCode = currentDownload->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    QUrl requestUrl = currentDownload->request().url();
    QVariant target = currentDownload->attribute(QNetworkRequest::RedirectionTargetAttribute);
    if (!target.isValid())
        return;
    QUrl redirectUrl = target.toUrl();
    if (redirectUrl.isRelative())
        redirectUrl = requestUrl.resolved(redirectUrl);
}
///
/// 删除该文件夹所有的图片
///
#include <QDir>
#include <QFileInfo>

void DownloadManager::removeFiles(const QString &path)
{
    //判断路径是否存在
    qDebug()<<Q_FUNC_INFO<<path;
    QDir dir(path);
    if(!dir.exists())
    {
        return;
    }
    //获取所选文件类型过滤器
    QStringList filters;
    filters<<QString("*.jpg")<<QString("*.png")<<QString("*.bmp")<<QString("*.gif");
    //定义迭代器并设置过滤器
    QDirIterator dir_iterator(path,
                              filters,
                              QDir::Files | QDir::NoSymLinks,
                              QDirIterator::Subdirectories);
    while(dir_iterator.hasNext())
    {
        dir_iterator.next();
        QFileInfo file_info = dir_iterator.fileInfo();
        QString file_path = file_info.absoluteFilePath();
        QFile::remove(file_path);
    }
    return;
}

QString DownloadManager::getCurDir()
{
    return adsPath;
}
