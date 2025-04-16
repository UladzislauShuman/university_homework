/********************************************************************************
** Form generated from reading UI file 'settingsdialog.ui'
**
** Created by: Qt User Interface Compiler version 6.6.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_SETTINGSDIALOG_H
#define UI_SETTINGSDIALOG_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_SettingsDialog
{
public:
    QVBoxLayout *verticalLayout;
    QGridLayout *gridLayout;
    QPushButton *okButton;
    QLabel *label;
    QLineEdit *widthEdit;
    QLabel *label_3;
    QLabel *label_2;
    QLineEdit *heightEdit;

    void setupUi(QDialog *SettingsDialog)
    {
        if (SettingsDialog->objectName().isEmpty())
            SettingsDialog->setObjectName("SettingsDialog");
        SettingsDialog->resize(365, 186);
        verticalLayout = new QVBoxLayout(SettingsDialog);
        verticalLayout->setObjectName("verticalLayout");
        gridLayout = new QGridLayout();
        gridLayout->setObjectName("gridLayout");
        okButton = new QPushButton(SettingsDialog);
        okButton->setObjectName("okButton");

        gridLayout->addWidget(okButton, 4, 0, 1, 1);

        label = new QLabel(SettingsDialog);
        label->setObjectName("label");
        QFont font;
        font.setPointSize(14);
        font.setBold(true);
        label->setFont(font);
        label->setAlignment(Qt::AlignCenter);

        gridLayout->addWidget(label, 1, 0, 2, 1);

        widthEdit = new QLineEdit(SettingsDialog);
        widthEdit->setObjectName("widthEdit");

        gridLayout->addWidget(widthEdit, 1, 2, 2, 1);

        label_3 = new QLabel(SettingsDialog);
        label_3->setObjectName("label_3");
        label_3->setFont(font);
        label_3->setAlignment(Qt::AlignCenter);

        gridLayout->addWidget(label_3, 0, 2, 1, 1);

        label_2 = new QLabel(SettingsDialog);
        label_2->setObjectName("label_2");
        label_2->setFont(font);
        label_2->setAlignment(Qt::AlignCenter);

        gridLayout->addWidget(label_2, 0, 1, 1, 1);

        heightEdit = new QLineEdit(SettingsDialog);
        heightEdit->setObjectName("heightEdit");

        gridLayout->addWidget(heightEdit, 1, 1, 2, 1);


        verticalLayout->addLayout(gridLayout);


        retranslateUi(SettingsDialog);

        QMetaObject::connectSlotsByName(SettingsDialog);
    } // setupUi

    void retranslateUi(QDialog *SettingsDialog)
    {
        SettingsDialog->setWindowTitle(QCoreApplication::translate("SettingsDialog", "Dialog", nullptr));
        okButton->setText(QCoreApplication::translate("SettingsDialog", "Ok", nullptr));
        label->setText(QCoreApplication::translate("SettingsDialog", "Size", nullptr));
        label_3->setText(QCoreApplication::translate("SettingsDialog", "Width", nullptr));
        label_2->setText(QCoreApplication::translate("SettingsDialog", "Height", nullptr));
    } // retranslateUi

};

namespace Ui {
    class SettingsDialog: public Ui_SettingsDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SETTINGSDIALOG_H
