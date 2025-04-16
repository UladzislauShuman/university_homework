/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 6.6.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStackedWidget>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;
    QGridLayout *gridLayout_2;
    QStackedWidget *stackedWidget;
    QWidget *menuPage;
    QGridLayout *gridLayout;
    QPushButton *settingsButton;
    QPushButton *startButton;
    QPushButton *playerButton;
    QWidget *gamePage;
    QGridLayout *gridLayout_4;
    QGridLayout *gridLayout_3;
    QPushButton *pushButton;
    QLineEdit *output;
    QLabel *label;
    QLineEdit *output_attempts;
    QGridLayout *gridLayout_5;
    QMenuBar *menubar;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName("MainWindow");
        MainWindow->resize(800, 600);
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName("centralwidget");
        gridLayout_2 = new QGridLayout(centralwidget);
        gridLayout_2->setObjectName("gridLayout_2");
        stackedWidget = new QStackedWidget(centralwidget);
        stackedWidget->setObjectName("stackedWidget");
        menuPage = new QWidget();
        menuPage->setObjectName("menuPage");
        gridLayout = new QGridLayout(menuPage);
        gridLayout->setObjectName("gridLayout");
        settingsButton = new QPushButton(menuPage);
        settingsButton->setObjectName("settingsButton");
        QSizePolicy sizePolicy(QSizePolicy::Policy::Expanding, QSizePolicy::Policy::Expanding);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(settingsButton->sizePolicy().hasHeightForWidth());
        settingsButton->setSizePolicy(sizePolicy);
        QFont font;
        font.setPointSize(20);
        font.setBold(true);
        settingsButton->setFont(font);

        gridLayout->addWidget(settingsButton, 1, 0, 1, 1);

        startButton = new QPushButton(menuPage);
        startButton->setObjectName("startButton");
        sizePolicy.setHeightForWidth(startButton->sizePolicy().hasHeightForWidth());
        startButton->setSizePolicy(sizePolicy);
        QFont font1;
        font1.setPointSize(20);
        font1.setBold(true);
        font1.setUnderline(false);
        font1.setKerning(true);
        startButton->setFont(font1);

        gridLayout->addWidget(startButton, 0, 0, 1, 1);

        playerButton = new QPushButton(menuPage);
        playerButton->setObjectName("playerButton");
        sizePolicy.setHeightForWidth(playerButton->sizePolicy().hasHeightForWidth());
        playerButton->setSizePolicy(sizePolicy);
        playerButton->setFont(font);

        gridLayout->addWidget(playerButton, 2, 0, 1, 1);

        stackedWidget->addWidget(menuPage);
        gamePage = new QWidget();
        gamePage->setObjectName("gamePage");
        gridLayout_4 = new QGridLayout(gamePage);
        gridLayout_4->setObjectName("gridLayout_4");
        gridLayout_3 = new QGridLayout();
        gridLayout_3->setObjectName("gridLayout_3");
        pushButton = new QPushButton(gamePage);
        pushButton->setObjectName("pushButton");
        QFont font2;
        font2.setBold(true);
        pushButton->setFont(font2);

        gridLayout_3->addWidget(pushButton, 0, 0, 1, 1);

        output = new QLineEdit(gamePage);
        output->setObjectName("output");

        gridLayout_3->addWidget(output, 0, 1, 1, 1);

        label = new QLabel(gamePage);
        label->setObjectName("label");

        gridLayout_3->addWidget(label, 0, 2, 1, 1);

        output_attempts = new QLineEdit(gamePage);
        output_attempts->setObjectName("output_attempts");

        gridLayout_3->addWidget(output_attempts, 0, 3, 1, 1);


        gridLayout_4->addLayout(gridLayout_3, 0, 0, 1, 1);

        gridLayout_5 = new QGridLayout();
        gridLayout_5->setObjectName("gridLayout_5");

        gridLayout_4->addLayout(gridLayout_5, 1, 0, 1, 1);

        stackedWidget->addWidget(gamePage);

        gridLayout_2->addWidget(stackedWidget, 0, 0, 1, 1);

        MainWindow->setCentralWidget(centralwidget);
        menubar = new QMenuBar(MainWindow);
        menubar->setObjectName("menubar");
        menubar->setGeometry(QRect(0, 0, 800, 21));
        MainWindow->setMenuBar(menubar);
        statusbar = new QStatusBar(MainWindow);
        statusbar->setObjectName("statusbar");
        MainWindow->setStatusBar(statusbar);

        retranslateUi(MainWindow);

        stackedWidget->setCurrentIndex(0);


        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QCoreApplication::translate("MainWindow", "MatrixGame", nullptr));
        settingsButton->setText(QCoreApplication::translate("MainWindow", "Settings", nullptr));
        startButton->setText(QCoreApplication::translate("MainWindow", "Start Game", nullptr));
        playerButton->setText(QCoreApplication::translate("MainWindow", "Player", nullptr));
        pushButton->setText(QCoreApplication::translate("MainWindow", "Back", nullptr));
        label->setText(QCoreApplication::translate("MainWindow", "Attempts: ", nullptr));
        output_attempts->setText(QCoreApplication::translate("MainWindow", "Tap on cells!", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
