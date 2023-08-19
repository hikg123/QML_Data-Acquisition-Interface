#include "fileio.h"

FileIO::FileIO()
{

}

QUrl FileIO::file_source() const
{
    return m_file_source;
}

void FileIO::setFile_source(const QUrl &newFile_source)
{
    if (m_file_source == newFile_source)
        return;
    m_file_source = newFile_source;
    emit file_sourceChanged();
}
void FileIO::read()
{

}
