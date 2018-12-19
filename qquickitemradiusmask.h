#ifndef MASKRECTANGLERADIUS_H
#define MASKRECTANGLERADIUS_H

#include <QObject>
#include <QPointF>
#include <QQuickItem>

QT_BEGIN_NAMESPACE

class QQuickItemRadiusMask : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged)

public:
    QQuickItemRadiusMask();

    bool contains(const QPointF &point) const;

    qreal radius() const { return m_radius; }
    void setRadius(qreal radius);

Q_SIGNALS:
    void radiusChanged();

private:
    qreal m_radius;

};

QT_END_NAMESPACE

QML_DECLARE_TYPE(QQuickItemRadiusMask)

#endif // MASKRECTANGLERADIUS_H
