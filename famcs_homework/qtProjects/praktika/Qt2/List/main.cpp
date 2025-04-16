#include "mainwindow.h"
#include "mylist.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    MyList<int> list();
    list.print();
    return a.exec();
}
