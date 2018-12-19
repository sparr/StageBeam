#include "qquickitemradiusmask.h"

QQuickItemRadiusMask::QQuickItemRadiusMask() { }

void QQuickItemRadiusMask::setRadius(qreal radius)
{
    if (m_radius != radius) {
        m_radius = radius;
        emit radiusChanged();
    }
}

bool QQuickItemRadiusMask::contains(const QPointF &point) const
{
    qreal x = point.x();
    qreal y = point.y();

    if (x < 0 || y < 0 || x > width() || y > height())
        // entirely outside the bounding box
        return false;

    if (width() == height() && m_radius >= width() / 2) {
        // special case for circle, hopefully the most common case
        qreal dx = width() / 2 - x;
        qreal dy = height() / 2 - y;
        return ( ( (dx * dx) + (dy * dy) ) <= (m_radius * m_radius) );
    }
    else {
        // points not near a corner are definitely inside
        if ((x > m_radius && x < width() - m_radius) ||
            (y > m_radius && y < height() - m_radius) ) {
            return true;
        }
        qreal dx, dy;
        if (x <= m_radius) {
            dx = x - m_radius;
        }
        else {
            dx = x - (width() - m_radius);
        }
        if (x <= m_radius) {
            dy = y - m_radius;
        }
        else {
            dy = y - (height() - m_radius);
        }
        return ( (dx * dx) + (dy * dy) <= (m_radius * m_radius) );
    }
}
