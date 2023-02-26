#include <toml.hpp>
#include <QDir>
#include <QDebug>

#include "coffeestyle.hpp"

std::istringstream readQrcToStdStream(const QString& path)
{
    // This is sadly needed to convert between qrc <> std::istream
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly | QIODevice::Text))
        exit(-1);
    QTextStream qts(&f);
    std::istringstream iss(qts.readAll().toStdString());
    return iss;
}

CoffeeStyle::CoffeeStyle(QObject* parent)
    : QQuickAttachedPropertyPropagator(parent)
{
    initialize();
    m_colorMap["background"];
    m_colorMap["area1"];
    m_colorMap["area2"];
    m_colorMap["highlighted"];
    m_colorMap["text"];
    m_colorMap["highlightedText"];
    m_colorMap["disabledText"];
    m_colorMap["icon"];
    m_colorMap["indicator"];
    m_colorMap["panelIndicator"];
    m_colorMap["handleIndicator"];
    m_colorMap["active"];
    m_colorMap["inactive"];
    m_colorMap["splitter"];

    if (initSchemes())
        loadColorScheme(m_availableSchemes[0].name);
    else {
        auto s = QDir::currentPath();
        qDebug() << "Scheme directory not found at: " << s;
    }
}

CoffeeStyle* CoffeeStyle::qmlAttachedProperties(QObject* object)
{
    return new CoffeeStyle(object);
}


bool CoffeeStyle::initSchemes(const QString& scheme_dir)
{
    auto scheme_files = QDir(scheme_dir).entryInfoList(QDir::Files | QDir::NoDotAndDotDot, QDir::Name);
    if (scheme_files.empty()) return false;
    for (const auto& fileInfo : std::as_const(scheme_files)) {
        if (fileInfo.suffix() == "toml") {
            const auto path = fileInfo.absoluteFilePath();
            auto ss = readQrcToStdStream(path);
            const auto tomlData = toml::parse(ss);

            const auto rootTable = toml::get<toml::table>(tomlData); // All tables in files
            for (const auto& subTable : rootTable) {
                auto temp = toml::get<toml::table>(subTable.second); // Get individual entries
                // Only process tables with the correct amount of entries
                if (temp.size() != m_colorMap.size()) continue; // TODO: issue warning
                m_availableSchemes.push_back({QString::fromStdString(subTable.first), path });
            }
        }
    }
    return true;
}

QString CoffeeStyle::scheme() const
{
    return m_activeScheme;
}

void CoffeeStyle::inheritScheme(const QString& schemeName)
{
    if (m_activeScheme == schemeName)
        return;
    loadColorScheme(schemeName);
    propagateScheme();
}
void CoffeeStyle::propagateScheme()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedPropertyPropagator* child : styles) {
        CoffeeStyle* style = qobject_cast<CoffeeStyle*>(child);
        if (style)
            style->inheritScheme(m_activeScheme);
    }
}

bool CoffeeStyle::loadColorScheme(const QString& schemeName) // TODO maybe throw?
{
    if (m_availableSchemes.empty()) return false;
    // Search for the specified theme name
    auto contains = [&schemeName](const SchemePath& sp) { return sp.name == schemeName; };
    auto scheme = std::find_if(m_availableSchemes.begin(), m_availableSchemes.end(), contains);
    if (scheme == m_availableSchemes.end()) return false; // Not found

    // As the toml file can contain multiple schemes, make sure to only load one table
    auto ss = readQrcToStdStream(scheme->path);
    const auto tomlData = toml::parse(ss);
    const auto keyVal = toml::find<toml::table>(tomlData, schemeName.toStdString());
    for (auto& i : m_colorMap) {
        const std::string temp = i.first.toStdString();
        if (auto it = keyVal.find(temp); it != keyVal.end())
            i.second = QColor::fromString(it->second.as_string().str);
        else {
            qDebug() << "[Scheme] key:" << temp << " not found!"; // TODO: Log
            return false;
        }
    }
    m_activeScheme = schemeName;
    emit themeChanged();
    return true;
}

QStringList CoffeeStyle::loadedSchemes() const
{
    QStringList out;
    out.reserve(m_availableSchemes.size());
    for (const auto& i : m_availableSchemes) {
        out.push_back(i.name);
    }
    return out;
}

const CoffeeStyle::ColorMap& CoffeeStyle::getColorMap() const
{
    return m_colorMap;
}

QColor CoffeeStyle::background() const
{
    return m_colorMap.at("background");
}
QColor CoffeeStyle::area1() const
{
    return m_colorMap.at("area1");
}
QColor CoffeeStyle::area2() const
{
    return m_colorMap.at("area2");
}
QColor CoffeeStyle::highlighted() const
{
    return m_colorMap.at("highlighted");
}
QColor CoffeeStyle::text() const
{
    return m_colorMap.at("text");
}
QColor CoffeeStyle::highlightedText() const
{
    return m_colorMap.at("highlightedText");
}
QColor CoffeeStyle::disabledText() const
{
    return m_colorMap.at("disabledText");
}
QColor CoffeeStyle::icon() const
{
    return m_colorMap.at("icon");
}
QColor CoffeeStyle::indicator() const
{
    return m_colorMap.at("indicator");
}
QColor CoffeeStyle::panelIndicator() const
{
    return m_colorMap.at("panelIndicator");
}
QColor CoffeeStyle::handleIndicator() const
{
    return m_colorMap.at("handleIndicator");
}
QColor CoffeeStyle::active() const
{
    return m_colorMap.at("active");
}
QColor CoffeeStyle::inactive() const
{
    return m_colorMap.at("inactive");
}
QColor CoffeeStyle::splitter() const
{
    return m_colorMap.at("splitter");
}


void CoffeeStyle::attachedParentChange(QQuickAttachedPropertyPropagator* newParent, QQuickAttachedPropertyPropagator* oldParent)
{
    Q_UNUSED(oldParent);
    auto* attachedParentStyle = qobject_cast<CoffeeStyle*>(newParent);
     if (attachedParentStyle)
         inheritScheme(attachedParentStyle->m_activeScheme);
}

