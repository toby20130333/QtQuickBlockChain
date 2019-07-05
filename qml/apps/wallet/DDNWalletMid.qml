import QtQuick 2.0
import "../blockchain/" as BlockChain

BlockChain.DDNTop{
    id:topBar
    signal signalChangePages(int index)
    dataModel: ListModel{
        id:dataMo;
        Component.onCompleted: {
                dataMo.append({blockText:"账户"})
                dataMo.append({blockText:"交易"})
                dataMo.append({blockText:"消息"})
        }
    }
    onSignalChangePage: {
        signalChangePages(index);
    }
}
