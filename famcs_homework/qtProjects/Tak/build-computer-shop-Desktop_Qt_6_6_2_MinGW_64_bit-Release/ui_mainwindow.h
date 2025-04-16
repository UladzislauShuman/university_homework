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
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;
    QLabel *label;
    QLabel *label_2;
    QLabel *label_3;
    QLabel *label_4;
    QLabel *label_5;
    QTextEdit *output;
    QWidget *gridLayoutWidget;
    QGridLayout *inputs;
    QLineEdit *editEndDate;
    QLineEdit *editProjectName;
    QLineEdit *editEmployeeName;
    QLineEdit *editDateOfCompletion;
    QLineEdit *editTask;
    QLineEdit *editStartDate;
    QPushButton *openButton;
    QPushButton *saveFileButton;
    QPushButton *addItemButton;
    QPushButton *searchButton;
    QPushButton *sortButton;
    QLabel *label_6;
    QPushButton *sortButton_2;
    QPushButton *pushButton;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName("MainWindow");
        MainWindow->resize(660, 430);
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName("centralwidget");
        label = new QLabel(centralwidget);
        label->setObjectName("label");
        label->setGeometry(QRect(10, 20, 49, 16));
        label_2 = new QLabel(centralwidget);
        label_2->setObjectName("label_2");
        label_2->setGeometry(QRect(10, 50, 141, 16));
        label_3 = new QLabel(centralwidget);
        label_3->setObjectName("label_3");
        label_3->setGeometry(QRect(10, 80, 61, 16));
        label_4 = new QLabel(centralwidget);
        label_4->setObjectName("label_4");
        label_4->setGeometry(QRect(10, 110, 151, 20));
        label_5 = new QLabel(centralwidget);
        label_5->setObjectName("label_5");
        label_5->setGeometry(QRect(10, 140, 111, 16));
        output = new QTextEdit(centralwidget);
        output->setObjectName("output");
        output->setGeometry(QRect(300, 10, 341, 141));
        gridLayoutWidget = new QWidget(centralwidget);
        gridLayoutWidget->setObjectName("gridLayoutWidget");
        gridLayoutWidget->setGeometry(QRect(150, 10, 121, 205));
        inputs = new QGridLayout(gridLayoutWidget);
        inputs->setObjectName("inputs");
        inputs->setContentsMargins(0, 0, 0, 0);
        editEndDate = new QLineEdit(gridLayoutWidget);
        editEndDate->setObjectName("editEndDate");

        inputs->addWidget(editEndDate, 6, 0, 1, 1);

        editProjectName = new QLineEdit(gridLayoutWidget);
        editProjectName->setObjectName("editProjectName");

        inputs->addWidget(editProjectName, 2, 0, 1, 1);

        editEmployeeName = new QLineEdit(gridLayoutWidget);
        editEmployeeName->setObjectName("editEmployeeName");

        inputs->addWidget(editEmployeeName, 0, 0, 1, 1);

        editDateOfCompletion = new QLineEdit(gridLayoutWidget);
        editDateOfCompletion->setObjectName("editDateOfCompletion");

        inputs->addWidget(editDateOfCompletion, 4, 0, 1, 1);

        editTask = new QLineEdit(gridLayoutWidget);
        editTask->setObjectName("editTask");

        inputs->addWidget(editTask, 3, 0, 1, 1);

        editStartDate = new QLineEdit(gridLayoutWidget);
        editStartDate->setObjectName("editStartDate");

        inputs->addWidget(editStartDate, 5, 0, 1, 1);

        openButton = new QPushButton(centralwidget);
        openButton->setObjectName("openButton");
        openButton->setGeometry(QRect(300, 170, 341, 24));
        saveFileButton = new QPushButton(centralwidget);
        saveFileButton->setObjectName("saveFileButton");
        saveFileButton->setGeometry(QRect(300, 200, 341, 24));
        addItemButton = new QPushButton(centralwidget);
        addItemButton->setObjectName("addItemButton");
        addItemButton->setGeometry(QRect(300, 230, 341, 24));
        searchButton = new QPushButton(centralwidget);
        searchButton->setObjectName("searchButton");
        searchButton->setGeometry(QRect(300, 260, 341, 24));
        sortButton = new QPushButton(centralwidget);
        sortButton->setObjectName("sortButton");
        sortButton->setGeometry(QRect(300, 290, 341, 24));
        label_6 = new QLabel(centralwidget);
        label_6->setObjectName("label_6");
        label_6->setGeometry(QRect(10, 170, 151, 16));
        sortButton_2 = new QPushButton(centralwidget);
        sortButton_2->setObjectName("sortButton_2");
        sortButton_2->setGeometry(QRect(300, 320, 341, 24));
        pushButton = new QPushButton(centralwidget);
        pushButton->setObjectName("pushButton");
        pushButton->setGeometry(QRect(20, 370, 83, 29));
        MainWindow->setCentralWidget(centralwidget);
        statusbar = new QStatusBar(MainWindow);
        statusbar->setObjectName("statusbar");
        MainWindow->setStatusBar(statusbar);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QCoreApplication::translate("MainWindow", "MainWindow", nullptr));
        label->setText(QCoreApplication::translate("MainWindow", "\320\244\320\230\320\236", nullptr));
        label_2->setText(QCoreApplication::translate("MainWindow", "\320\235\320\260\320\267\320\262\320\260\320\275\320\270\320\265 \320\277\321\200\320\276\320\265\320\272\321\202\320\260", nullptr));
        label_3->setText(QCoreApplication::translate("MainWindow", "\320\227\320\260\320\264\320\260\320\275\320\270\320\265 ", nullptr));
        label_4->setText(QCoreApplication::translate("MainWindow", "\320\224\320\260\321\202\320\260 \320\262\321\213\320\277\320\276\320\273\320\275\320\265\320\275\320\270\321\217 ", nullptr));
        label_5->setText(QCoreApplication::translate("MainWindow", "\320\224\320\260\321\202\321\213 \320\275\320\260\321\207\320\260\320\273\320\260", nullptr));
        openButton->setText(QCoreApplication::translate("MainWindow", "\320\236\321\202\320\272\321\200\321\213\321\202\321\214", nullptr));
        saveFileButton->setText(QCoreApplication::translate("MainWindow", "\320\241\320\276\321\205\321\200\320\260\320\275\320\270\321\202\321\214", nullptr));
        addItemButton->setText(QCoreApplication::translate("MainWindow", "\320\224\320\276\320\261\320\260\320\262\320\270\321\202\321\214", nullptr));
        searchButton->setText(QCoreApplication::translate("MainWindow", "\320\232\320\276\320\273\320\270\321\207\320\265\321\201\321\202\320\262\320\276 \320\264\320\275\320\265\320\271 \321\200\320\260\320\261\320\276\321\202\321\213", nullptr));
        sortButton->setText(QCoreApplication::translate("MainWindow", "\320\241\320\276\321\200\321\202\320\270\321\200\320\276\320\262\320\272\320\260 ", nullptr));
        label_6->setText(QCoreApplication::translate("MainWindow", "\320\224\320\260\321\202\321\213 \320\276\320\272\320\276\320\275\321\207\320\260\320\275\320\270\321\217", nullptr));
        sortButton_2->setText(QCoreApplication::translate("MainWindow", "\320\236\321\207\320\270\321\201\321\202\320\270\321\202\321\214", nullptr));
        pushButton->setText(QCoreApplication::translate("MainWindow", "\320\222\321\213\320\271\321\202\320\270", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
