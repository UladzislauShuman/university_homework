/********************************************************************************
** Form generated from reading UI file 'playerdialog.ui'
**
** Created by: Qt User Interface Compiler version 6.6.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_PLAYERDIALOG_H
#define UI_PLAYERDIALOG_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStackedWidget>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_PlayerDialog
{
public:
    QGridLayout *gridLayout_2;
    QStackedWidget *stackedWidget;
    QWidget *playerPage;
    QGridLayout *gridLayout_3;
    QGridLayout *gridLayout;
    QLabel *nameLabel;
    QLabel *currentLevelLabel;
    QLabel *player_nameLabel;
    QLabel *player_maxLevelLabel;
    QLabel *player_currentLevelLabel;
    QLabel *maxLevelLabel;
    QGridLayout *gridLayout_5;
    QPushButton *okButton;
    QPushButton *chooseProfileButton;
    QPushButton *makeProfileButton;
    QWidget *makePlayerPage;
    QWidget *layoutWidget;
    QGridLayout *gridLayout_4;
    QLineEdit *nameEdit;
    QLabel *maxLevelLabel_2;
    QLabel *currentLevelLabel_2;
    QPushButton *backButton;
    QLabel *nameLabel_2;
    QPushButton *createButton;
    QLabel *maxLevelLabel_;
    QLabel *currentLevelLabel_;

    void setupUi(QDialog *PlayerDialog)
    {
        if (PlayerDialog->objectName().isEmpty())
            PlayerDialog->setObjectName("PlayerDialog");
        PlayerDialog->resize(956, 272);
        gridLayout_2 = new QGridLayout(PlayerDialog);
        gridLayout_2->setObjectName("gridLayout_2");
        stackedWidget = new QStackedWidget(PlayerDialog);
        stackedWidget->setObjectName("stackedWidget");
        playerPage = new QWidget();
        playerPage->setObjectName("playerPage");
        gridLayout_3 = new QGridLayout(playerPage);
        gridLayout_3->setObjectName("gridLayout_3");
        gridLayout = new QGridLayout();
        gridLayout->setObjectName("gridLayout");
        nameLabel = new QLabel(playerPage);
        nameLabel->setObjectName("nameLabel");
        QFont font;
        font.setPointSize(23);
        font.setBold(true);
        nameLabel->setFont(font);

        gridLayout->addWidget(nameLabel, 0, 0, 1, 1);

        currentLevelLabel = new QLabel(playerPage);
        currentLevelLabel->setObjectName("currentLevelLabel");
        currentLevelLabel->setFont(font);

        gridLayout->addWidget(currentLevelLabel, 2, 0, 1, 1);

        player_nameLabel = new QLabel(playerPage);
        player_nameLabel->setObjectName("player_nameLabel");
        QFont font1;
        font1.setPointSize(20);
        player_nameLabel->setFont(font1);

        gridLayout->addWidget(player_nameLabel, 0, 1, 1, 1);

        player_maxLevelLabel = new QLabel(playerPage);
        player_maxLevelLabel->setObjectName("player_maxLevelLabel");
        player_maxLevelLabel->setFont(font1);

        gridLayout->addWidget(player_maxLevelLabel, 1, 1, 1, 1);

        player_currentLevelLabel = new QLabel(playerPage);
        player_currentLevelLabel->setObjectName("player_currentLevelLabel");
        player_currentLevelLabel->setFont(font1);

        gridLayout->addWidget(player_currentLevelLabel, 2, 1, 1, 1);

        maxLevelLabel = new QLabel(playerPage);
        maxLevelLabel->setObjectName("maxLevelLabel");
        maxLevelLabel->setFont(font);

        gridLayout->addWidget(maxLevelLabel, 1, 0, 1, 1);

        gridLayout_5 = new QGridLayout();
        gridLayout_5->setObjectName("gridLayout_5");
        okButton = new QPushButton(playerPage);
        okButton->setObjectName("okButton");
        QSizePolicy sizePolicy(QSizePolicy::Policy::Expanding, QSizePolicy::Policy::MinimumExpanding);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(okButton->sizePolicy().hasHeightForWidth());
        okButton->setSizePolicy(sizePolicy);

        gridLayout_5->addWidget(okButton, 0, 3, 1, 1);

        chooseProfileButton = new QPushButton(playerPage);
        chooseProfileButton->setObjectName("chooseProfileButton");
        sizePolicy.setHeightForWidth(chooseProfileButton->sizePolicy().hasHeightForWidth());
        chooseProfileButton->setSizePolicy(sizePolicy);

        gridLayout_5->addWidget(chooseProfileButton, 0, 0, 1, 1);

        makeProfileButton = new QPushButton(playerPage);
        makeProfileButton->setObjectName("makeProfileButton");
        QSizePolicy sizePolicy1(QSizePolicy::Policy::Expanding, QSizePolicy::Policy::Expanding);
        sizePolicy1.setHorizontalStretch(0);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(makeProfileButton->sizePolicy().hasHeightForWidth());
        makeProfileButton->setSizePolicy(sizePolicy1);

        gridLayout_5->addWidget(makeProfileButton, 0, 1, 1, 1);


        gridLayout->addLayout(gridLayout_5, 4, 0, 1, 2);


        gridLayout_3->addLayout(gridLayout, 0, 0, 1, 2);

        stackedWidget->addWidget(playerPage);
        makePlayerPage = new QWidget();
        makePlayerPage->setObjectName("makePlayerPage");
        makePlayerPage->setLayoutDirection(Qt::LeftToRight);
        layoutWidget = new QWidget(makePlayerPage);
        layoutWidget->setObjectName("layoutWidget");
        layoutWidget->setGeometry(QRect(20, 22, 911, 222));
        gridLayout_4 = new QGridLayout(layoutWidget);
        gridLayout_4->setObjectName("gridLayout_4");
        gridLayout_4->setContentsMargins(0, 0, 0, 0);
        nameEdit = new QLineEdit(layoutWidget);
        nameEdit->setObjectName("nameEdit");
        sizePolicy1.setHeightForWidth(nameEdit->sizePolicy().hasHeightForWidth());
        nameEdit->setSizePolicy(sizePolicy1);

        gridLayout_4->addWidget(nameEdit, 1, 2, 1, 1);

        maxLevelLabel_2 = new QLabel(layoutWidget);
        maxLevelLabel_2->setObjectName("maxLevelLabel_2");
        maxLevelLabel_2->setFont(font);

        gridLayout_4->addWidget(maxLevelLabel_2, 3, 0, 1, 1);

        currentLevelLabel_2 = new QLabel(layoutWidget);
        currentLevelLabel_2->setObjectName("currentLevelLabel_2");
        currentLevelLabel_2->setFont(font);

        gridLayout_4->addWidget(currentLevelLabel_2, 4, 0, 1, 1);

        backButton = new QPushButton(layoutWidget);
        backButton->setObjectName("backButton");

        gridLayout_4->addWidget(backButton, 0, 0, 1, 1);

        nameLabel_2 = new QLabel(layoutWidget);
        nameLabel_2->setObjectName("nameLabel_2");
        nameLabel_2->setFont(font);

        gridLayout_4->addWidget(nameLabel_2, 1, 0, 1, 1);

        createButton = new QPushButton(layoutWidget);
        createButton->setObjectName("createButton");

        gridLayout_4->addWidget(createButton, 5, 0, 1, 1);

        maxLevelLabel_ = new QLabel(layoutWidget);
        maxLevelLabel_->setObjectName("maxLevelLabel_");
        QFont font2;
        font2.setPointSize(14);
        font2.setBold(true);
        maxLevelLabel_->setFont(font2);
        maxLevelLabel_->setAlignment(Qt::AlignCenter);

        gridLayout_4->addWidget(maxLevelLabel_, 3, 2, 1, 1);

        currentLevelLabel_ = new QLabel(layoutWidget);
        currentLevelLabel_->setObjectName("currentLevelLabel_");
        currentLevelLabel_->setFont(font2);
        currentLevelLabel_->setAlignment(Qt::AlignCenter);

        gridLayout_4->addWidget(currentLevelLabel_, 4, 2, 1, 1);

        stackedWidget->addWidget(makePlayerPage);

        gridLayout_2->addWidget(stackedWidget, 0, 0, 1, 1);


        retranslateUi(PlayerDialog);

        stackedWidget->setCurrentIndex(0);


        QMetaObject::connectSlotsByName(PlayerDialog);
    } // setupUi

    void retranslateUi(QDialog *PlayerDialog)
    {
        PlayerDialog->setWindowTitle(QCoreApplication::translate("PlayerDialog", "Dialog", nullptr));
        nameLabel->setText(QCoreApplication::translate("PlayerDialog", "Name :", nullptr));
        currentLevelLabel->setText(QCoreApplication::translate("PlayerDialog", "Current Level :", nullptr));
        player_nameLabel->setText(QString());
        player_maxLevelLabel->setText(QString());
        player_currentLevelLabel->setText(QString());
        maxLevelLabel->setText(QCoreApplication::translate("PlayerDialog", "MaxLevel :", nullptr));
        okButton->setText(QCoreApplication::translate("PlayerDialog", "OK", nullptr));
        chooseProfileButton->setText(QCoreApplication::translate("PlayerDialog", "Choose profile", nullptr));
        makeProfileButton->setText(QCoreApplication::translate("PlayerDialog", "Make profile", nullptr));
        maxLevelLabel_2->setText(QCoreApplication::translate("PlayerDialog", "MaxLevel :", nullptr));
        currentLevelLabel_2->setText(QCoreApplication::translate("PlayerDialog", "Current Level :", nullptr));
        backButton->setText(QCoreApplication::translate("PlayerDialog", "Back", nullptr));
        nameLabel_2->setText(QCoreApplication::translate("PlayerDialog", "Name :", nullptr));
        createButton->setText(QCoreApplication::translate("PlayerDialog", "Create", nullptr));
        maxLevelLabel_->setText(QCoreApplication::translate("PlayerDialog", "1", nullptr));
        currentLevelLabel_->setText(QCoreApplication::translate("PlayerDialog", "1", nullptr));
    } // retranslateUi

};

namespace Ui {
    class PlayerDialog: public Ui_PlayerDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_PLAYERDIALOG_H
