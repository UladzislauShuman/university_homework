#include "mainwindow.h"
#include "stack.h"

#include <QApplication>

int main(int argc, char* argv[])
{
    Stack mainStack;
    QApplication app(argc, argv);
    MainWindow window;
    window.show();
    return app.exec();
}
