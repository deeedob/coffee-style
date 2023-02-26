#include "borderrectangle.hpp"
#include <QtQuick/QSGNode>
#include <QtQuick/QSGSimpleRectNode>

BorderRectangle::BorderRectangle(QQuickItem *parent)
    : QQuickItem(parent), mColor(QColor(Qt::black)), mBorderColor(Qt::white),
    mTopBorder(0), mRightBorder(0), mBottomBorder(0), mLeftBorder(0)
{
    setFlag(ItemHasContents, true);
}

QSGNode *BorderRectangle::updatePaintNode(QSGNode *oldNode, QQuickItem::UpdatePaintNodeData *data)
{
    Q_UNUSED(data)
    QSGNode* parentNode = nullptr;
    QSGSimpleRectNode *fillNode = nullptr;
    QSGSimpleRectNode *topNode = nullptr;
    QSGSimpleRectNode *rightNode = nullptr;
    QSGSimpleRectNode *bottomNode = nullptr;
    QSGSimpleRectNode *leftNode = nullptr;

    if (oldNode) {
        parentNode = oldNode;
        fillNode = static_cast<QSGSimpleRectNode*>(parentNode->childAtIndex(0));
        topNode = static_cast<QSGSimpleRectNode*>(parentNode->childAtIndex(1));
        rightNode = static_cast<QSGSimpleRectNode*>(parentNode->childAtIndex(2));
        bottomNode = static_cast<QSGSimpleRectNode*>(parentNode->childAtIndex(3));
        leftNode = static_cast<QSGSimpleRectNode*>(parentNode->childAtIndex(4));
    }
    if (!parentNode) {
        parentNode = new QSGNode;
        fillNode = new QSGSimpleRectNode;
        topNode = new QSGSimpleRectNode;
        rightNode = new QSGSimpleRectNode;
        bottomNode = new QSGSimpleRectNode;
        leftNode = new QSGSimpleRectNode;

        parentNode->appendChildNode(fillNode);
        parentNode->appendChildNode(topNode);
        parentNode->appendChildNode(rightNode);
        parentNode->appendChildNode(bottomNode);
        parentNode->appendChildNode(leftNode);
    }

    fillNode->setRect(boundingRect());
    fillNode->setColor(mColor);
    topNode->setRect(0, 0, width(), mTopBorder);
    topNode->setColor(mBorderColor);
    rightNode->setRect(width() - mRightBorder, 0, mRightBorder, height());
    rightNode->setColor(mBorderColor);
    bottomNode->setRect(0, height() - mBottomBorder, width(), mBottomBorder);
    bottomNode->setColor(mBorderColor);
    leftNode->setRect(0, 0, mLeftBorder, height());
    leftNode->setColor(mBorderColor);

    return parentNode;
}
