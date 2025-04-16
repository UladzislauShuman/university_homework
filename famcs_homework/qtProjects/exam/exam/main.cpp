#include "mainwindow.h"

#include <QApplication>
//Qicon
#include <QIcon>
// QPallete, QBrush
#include <QBrush>
//QLabel
#include <QLabel>
#include <QVBoxLayout>

#include <QWidget>
#include <QSplitter>
#include <QTextEdit>
#include <QScrollArea>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    // //поменеяем Widget
    // w.resize(350,70);
    // w.setWindowTitle("Проба");
    // w.setToolTip("что это?");
    // //наверное стоит найти .png
    // w.setWindowIcon(QIcon(":/icon/icon1.jpg"));
    // //полупрозрачность
    // w.setWindowOpacity(0.7);

    // //сделаем фон
    // QPalette pal = w.palette();
    //           //обычное состояние виджета //цвет фона кого //кисть Зелёная  //сплошное заполнение
    // pal.setBrush(QPalette::Normal, QPalette::Window,QBrush(QColor(0,128,0), Qt::SolidPattern));
    // //QBrush(QPixmap("точный путь"))
    // w.setPalette(pal);

    // //строка
    // QLabel *label = new QLabel("ТекстНадписи");
    // label->setAlignment(Qt::AlignCenter); // расположение?
    // label->setStyleSheet("background-color: #ffffff;");
    // //"background-image: url(путь);"
    // label->setAutoFillBackground(true);

    // //layout
    // QVBoxLayout *vbox = new QVBoxLayout();
    // vbox->addWidget(label);
    // w.setLayout(vbox);

    w.show();

    return a.exec();
}
