#pragma once

#include <QtQuick/QQuickItem>
#include <QtQuick/QSGGeometry>
#include <QtGui/QColor>

class BorderRectangle : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QColor color MEMBER mColor NOTIFY colorChanged)
    Q_PROPERTY(QColor borderColor MEMBER mBorderColor NOTIFY borderColorChanged)
    Q_PROPERTY(qreal topBorder MEMBER mTopBorder NOTIFY topBorderChanged)
    Q_PROPERTY(qreal rightBorder MEMBER mRightBorder NOTIFY rightBorderChanged)
    Q_PROPERTY(qreal bottomBorder MEMBER mBottomBorder NOTIFY bottomBorderChanged)
    Q_PROPERTY(qreal leftBorder MEMBER mLeftBorder NOTIFY leftBorderChanged)
    QML_ELEMENT
public:
    BorderRectangle(QQuickItem* parent = nullptr );

Q_SIGNALS:
    void colorChanged();
    void borderColorChanged();
    void topBorderChanged();
    void rightBorderChanged();
    void bottomBorderChanged();
    void leftBorderChanged();

protected:
    QSGNode *updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *data) override;
private:
    QColor mColor;
    QColor mBorderColor;
    qreal mTopBorder;
    qreal mRightBorder;
    qreal mBottomBorder;
    qreal mLeftBorder;
};
