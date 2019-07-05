function createSpriteObjects(obj,qmlfile) {
    var component = Qt.createComponent(qmlfile);
    return component;
}
function createqmlObjects(obj,qmlfile,margin) {
    var component = Qt.createComponent(qmlfile);
    var createObj = component.createObject(obj,{"x": 0, "y": 0,"anchors.fill":obj,"anchors.margins":margin});
    return createObj;
}

