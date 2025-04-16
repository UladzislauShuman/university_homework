#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QString>
#include <QTimer>
#include <QDebug>

#include <string>
#include <fstream>

#include "settingsdialog.h"
#include "cell.h"
#include "field.h"
#include "playerdialog.h"
#include "windialog.h"

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_startButton_clicked();
    void on_pushButton_clicked();
    void on_settingsButton_clicked();
    void on_playerButton_clicked();

public slots:
    void takeCurrentXY(int,int);
    void takeFieldSize(int,int);
    void takePlayer(Player,std::string);
    void takeAttemptsFromField(int);
    void takeSignalNext(bool);
    void takeSignalMakeNewField(bool);
    void takePlayerOrSettings(bool);

signals:
    void SignalPlayerMainWindow(Player*);
    void SignalWaitAMinute();
private:
    Ui::MainWindow *ui;
    int field_height;
    int field_width;
    int gameMode;

    SettingsDialog* settingsdialog;
    PlayerDialog* playerdialog;
    Field* field;

    Player* player;
    std::string current_file_name;
    void PrintPlayer();

    bool flag_player_or_settings;



};
#endif // MAINWINDOW_H
