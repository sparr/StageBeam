#ifndef RADIUSMOUSEAREA_H
#define RADIUSMOUSEAREA_H

#include <QQuickItem>
#include <QtQuick/private/qquickmousearea_p.h>
#include <QtQuick/private/qtquickglobal_p.h>
#include "QtQuick/private/qquickitem_p.h"
#include <QtCore/qmetaobject.h>

class RadiusMouseArea : public QQuickMouseArea
{
    Q_OBJECT

    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged)

public:
    RadiusMouseArea();
    RadiusMouseArea(QQuickItem *parent);
    bool contains(const QPointF &point) const;
    qreal radius() const { return m_radius; }
    void setRadius(qreal radius);

Q_SIGNALS:
    void radiusChanged();

private:
    qreal m_radius;

};

#endif // RADIUSMOUSEAREA_H
