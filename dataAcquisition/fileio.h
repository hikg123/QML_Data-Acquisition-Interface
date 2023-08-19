#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QString>
#include <QtCore>

class FileIO:public QObject
{
    Q_OBJECT
public:
    FileIO();
    //定义QML可以访问的方法，函数必须要Q_INVOKABLE修饰
    Q_INVOKABLE void read();

    QUrl  file_source() const;
    void setFile_source(const QUrl &newFile_source);

signals:
    void file_sourceChanged();

private:
    QUrl  m_file_source;

    //定义QML可以访问的属性,在qml中读用file_source，写用setFile_source
    Q_PROPERTY(QUrl file_source READ file_source WRITE setFile_source NOTIFY file_sourceChanged)
};

#endif // FILEIO_H
