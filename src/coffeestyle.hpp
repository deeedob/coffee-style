#include <QColor>
#include <QQmlEngine>
#include <QQuickAttachedPropertyPropagator>
#include <QDir>
#include "coffeestyle_export.h"

class COFFEESTYLE_EXPORT CoffeeStyle : public QQuickAttachedPropertyPropagator
{
    Q_OBJECT

    Q_PROPERTY(QString scheme READ scheme WRITE inheritScheme NOTIFY themeChanged FINAL)
    Q_PROPERTY(QStringList schemeList READ loadedSchemes NOTIFY themeChanged FINAL)

    Q_PROPERTY(QColor background READ background NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor area1 READ area1 NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor area2 READ area2 NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor highlighted READ highlighted NOTIFY themeChanged FINAL)

    Q_PROPERTY(QColor text READ text NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor disabledText READ disabledText NOTIFY themeChanged FINAL)

    Q_PROPERTY(QColor icon READ icon NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor indicator READ indicator NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor panelIndicator READ panelIndicator NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor active READ active NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor inactive READ inactive NOTIFY themeChanged FINAL)

    Q_PROPERTY(int menuBarHeight READ menuBarHeight NOTIFY sizeChanged FINAL)

    QML_ELEMENT
    QML_ATTACHED(CoffeeStyle)
    QML_UNCREATABLE("")

    struct SchemePath { QString name, path; };
    using ColorMap = std::unordered_map<QString, QColor>;
public:
    explicit CoffeeStyle(QObject* parent = nullptr);
    static CoffeeStyle* qmlAttachedProperties(QObject* object);

    bool initSchemes(const QString& scheme_dir = ":/qt/qml/Coffee/Style/schemes");

    QString scheme() const;
    void inheritScheme(const QString& schemeName);
    void propagateScheme();
    Q_INVOKABLE bool loadColorScheme(const QString& schemeName);

    QStringList loadedSchemes() const;
    const ColorMap& getColorMap() const;
    // TODO: add watcher dir

    QColor background() const;
    QColor area1() const;
    QColor area2() const;
    QColor highlighted() const;
    QColor text() const;
    QColor disabledText() const;
    QColor icon() const;
    QColor indicator() const;
    QColor panelIndicator() const;
    QColor active() const;
    QColor inactive() const;

    int menuBarHeight() const { return 25; }
Q_SIGNALS:
    void themeChanged();
    void sizeChanged();

protected:
    void attachedParentChange(QQuickAttachedPropertyPropagator* newParent, QQuickAttachedPropertyPropagator* oldParent) override;

private:
    std::vector<SchemePath> m_availableSchemes;
    ColorMap m_colorMap;
    QString m_activeScheme;
};
