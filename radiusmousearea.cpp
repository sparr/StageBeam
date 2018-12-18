#include "radiusmousearea.h"

RadiusMouseArea::RadiusMouseArea() { }

RadiusMouseArea::RadiusMouseArea(QQuickItem *parent)
    : QQuickMouseArea(parent)
{ }

void RadiusMouseArea::setRadius(qreal radius)
{
    if (m_radius != radius) {
        m_radius = radius;
        emit radiusChanged();
    }
}

bool RadiusMouseArea::contains(const QPointF &point) const
{
    if (!QQuickItem::contains(point))
        return false;

    if (width() == height() && m_radius >= width() / 2) {
        // special case for circle, hopefully the most common case
        qreal dx = width() / 2 - point.x();
        qreal dy = height() / 2 - point.y();
        return dx * dx + dy * dy <= m_radius * m_radius;
    }
    else {
        // point more than radius distance from a corner is good
        if ((point.x() > m_radius && point.x() < width() - m_radius) ||
            (point.y() > m_radius && point.y() < height() - m_radius) ) {
            return true;
        }
        qreal dx, dy;
        if (point.x() <= m_radius) {
            dx = point.x() - m_radius;
        }
        else {
            dx = width() - m_radius - point.x();
        }
        if (point.x() <= m_radius) {
            dy = point.y() - m_radius;
        }
        else {
            dy = height() - m_radius - point.y();
        }
        return dx * dx + dy * dy <= m_radius * m_radius;
    }
}
