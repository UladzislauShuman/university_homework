/********************************************************************************
** Form generated from reading UI file 'windialog.ui'
**
** Created by: Qt User Interface Compiler version 6.6.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WINDIALOG_H
#define UI_WINDIALOG_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_WinDialog
{
public:
    QGridLayout *gridLayout;
    QVBoxLayout *verticalLayout;
    QLabel *resultLabel;
    QPushButton *nextButton;

    void setupUi(QDialog *WinDialog)
    {
        if (WinDialog->objectName().isEmpty())
            WinDialog->setObjectName("WinDialog");
        WinDialog->resize(204, 151);
        QFont font;
        font.setPointSize(20);
        WinDialog->setFont(font);
        gridLayout = new QGridLayout(WinDialog);
        gridLayout->setObjectName("gridLayout");
        verticalLayout = new QVBoxLayout();
        verticalLayout->setObjectName("verticalLayout");
        resultLabel = new QLabel(WinDialog);
        resultLabel->setObjectName("resultLabel");
        QFont font1;
        font1.setPointSize(20);
        font1.setBold(true);
        resultLabel->setFont(font1);
        resultLabel->setAlignment(Qt::AlignCenter);

        verticalLayout->addWidget(resultLabel);

        nextButton = new QPushButton(WinDialog);
        nextButton->setObjectName("nextButton");
        nextButton->setFont(font1);

        verticalLayout->addWidget(nextButton);


        gridLayout->addLayout(verticalLayout, 0, 0, 1, 1);


        retranslateUi(WinDialog);

        QMetaObject::connectSlotsByName(WinDialog);
    } // setupUi

    void retranslateUi(QDialog *WinDialog)
    {
        WinDialog->setWindowTitle(QCoreApplication::translate("WinDialog", "Dialog", nullptr));
        resultLabel->setText(QString());
        nextButton->setText(QCoreApplication::translate("WinDialog", "NEXT", nullptr));
    } // retranslateUi

};

namespace Ui {
    class WinDialog: public Ui_WinDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WINDIALOG_H
