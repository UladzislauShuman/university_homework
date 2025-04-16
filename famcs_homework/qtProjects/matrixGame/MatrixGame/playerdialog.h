#ifndef PLAYERDIALOG_H
#define PLAYERDIALOG_H

#include <QDebug>
#include <QDialog>
#include <QFileDialog>
#include <QTextStream>

#include <fstream>
#include <string>

#include "player.h"

namespace Ui {
class PlayerDialog;
}

class PlayerDialog : public QDialog
{
    Q_OBJECT

public:
    explicit PlayerDialog(QWidget *parent = nullptr);
    ~PlayerDialog();
    std::string GetPlayerFileName(){
        qDebug() << "PlayerDialog::GetPlayerFileName()"<<Qt::endl;
        return this->current_player_file;}

private slots:
    void on_okButton_clicked();
    void on_chooseProfileButton_clicked();

    void on_makeProfileButton_clicked();

    void on_createButton_clicked();

    void on_backButton_clicked();

public slots:
    void takePlayerFromMainWindow(Player*);
signals:
    void SignalPlayer(Player,std::string);
    void SignalPlayerWasChoosen(bool);
private:
    Ui::PlayerDialog *ui;
    Player* player;
    void PrintInf();
    void ReadFile(std::string);

    std::string current_player_file;
};

#endif // PLAYERDIALOG_H
