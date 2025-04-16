#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    qDebug() << "MainWindow()"<<Qt::endl;
    ui->setupUi(this);
    this->flag_player_or_settings = false;
    this->field_height = 4;
    this->field_width = 4;
    this->gameMode = 5;

    this->settingsdialog = new SettingsDialog();
    //this->settingsdialog->setAttribute(Qt::WA_DeleteOnClose);
    this->settingsdialog->setWindowTitle("Settings");
    connect(settingsdialog,&SettingsDialog::Signal_Width_Height,this,&MainWindow::takeFieldSize);
    connect(settingsdialog,&SettingsDialog::SignalSettingsWereChoosen,this,&MainWindow::takePlayerOrSettings);

    this->field = new Field(this->field_width,this->field_height);

    connect(field,&Field::SignalXY_current,this,&MainWindow::takeCurrentXY);
    connect(field,&Field::SignalAttempts,this,&MainWindow::takeAttemptsFromField);
    connect(this->field->GetWinDialog(),&WinDialog::SignalNext,this,&MainWindow::takeSignalNext);
    connect(this->field->GetWinDialog(),&WinDialog::SignalMakeNewField,this,&MainWindow::takeSignalMakeNewField);

    this->playerdialog = new PlayerDialog();
    connect(playerdialog,&PlayerDialog::SignalPlayer,this,&MainWindow::takePlayer);
    connect(this,&MainWindow::SignalPlayerMainWindow,playerdialog,&PlayerDialog::takePlayerFromMainWindow);
    connect(playerdialog,&PlayerDialog::SignalPlayerWasChoosen,this,&MainWindow::takePlayerOrSettings);

    this->player = new Player();
}

MainWindow::~MainWindow()
{
    qDebug() << "~MainWindow()"<<Qt::endl;
    delete ui;
    delete field;
    delete settingsdialog;
    delete player;

}

void MainWindow::on_startButton_clicked()
{
    qDebug() << "MainWindow::on_startButton_clicked()"<<Qt::endl;
    this->ui->gamePage->setLayout(nullptr);
    delete this->field;
    if(this->flag_player_or_settings == false){
        this->field = new Field(this->field_width,this->field_height);
    }
    else{
        this->field = new Field(*this->player);
    }
    //this->field = new Field(this->field_width,this->field_height);
    connect(field,&Field::SignalXY_current,this,&MainWindow::takeCurrentXY);
    connect(field,&Field::SignalAttempts,this,&MainWindow::takeAttemptsFromField);
    //connect(this,&MainWindow::SignalWaitAMinute,this->field,&Field::WaitAMinute);
    /////////////////
    connect(this->field->GetWinDialog(),&WinDialog::SignalNext,this,&MainWindow::takeSignalNext);
    connect(this->field->GetWinDialog(),&WinDialog::SignalMakeNewField,this,&MainWindow::takeSignalMakeNewField);
    //////////////////
    //this->ui->gamePage->setLayout(this->field->GetLayout());
    this->ui->gridLayout_5->addLayout(this->field->GetLayout(),0,0);
    this->ui->stackedWidget->setCurrentWidget(this->ui->gamePage);

}


void MainWindow::on_pushButton_clicked()
{
    qDebug() << "MainWindow::on_backButton_clicked()"<<Qt::endl;
    this->ui->stackedWidget->setCurrentWidget(this->ui->menuPage);
}

void MainWindow::on_settingsButton_clicked()
{
    qDebug() << "MainWindow::on_settingsButton_clicked()"<<Qt::endl;
    this->settingsdialog->show();
}

void MainWindow::on_playerButton_clicked()
{
    qDebug() << "MainWindow::on_playerButton_clicked()"<<Qt::endl;
    this->playerdialog->show();
}

void MainWindow::takeCurrentXY(int x, int y)
{
    qDebug() << "MainWindow::takeCurrentXY()"<<Qt::endl;
    this->ui->output->setText(QString::number(x)+" "+QString::number(y));
}

void MainWindow::takeFieldSize(int width, int height)
{
    qDebug() << "MainWindow::takeFieldSize()"<<Qt::endl;
    this->field_width = width;
    this->field_height = height;
}

void MainWindow::takePlayer(Player player_,std::string current_player_file_)
{
    qDebug() << "MainWindow::takePlayer()"<<Qt::endl;
    this->field_width = 2*player_.GetCurrentLevel();
    this->field_height = 2*player_.GetCurrentLevel();

    delete this->player;
    this->player = new Player(player_);
    this->current_file_name = current_player_file_;

}

void MainWindow::takeAttemptsFromField(int attempts_)
{
    qDebug() << "MainWindow::takeAttemptsFromField()"<<Qt::endl;
    this->ui->output_attempts->setText(QString::number(attempts_));
}

void MainWindow::takeSignalNext(bool next)
{
    qDebug() << "MainWindow::takeSignalNext()"<<Qt::endl;
    if(next){
        qDebug() << "next == true"<<Qt::endl;
        this->player->SetCurrentLevel(this->player->GetCurrentLevel()+1);
    }
    else{
        qDebug() << "next == false"<<Qt::endl;
        this->player->SetCurrentLevel(this->player->GetCurrentLevel()-1);
    }
    //имеет ли смысл именно здесь его держать?
    if(this->player->GetCurrentLevel() > this->player->GetMaxLevel()){
        this->player->SetMaxLevel(this->player->GetCurrentLevel());
    }

    if(this->current_file_name.empty() == false){
        std::ofstream out;
        out.open(this->current_file_name,std::ios::out|std::ios::trunc);
        out << this->player->GetName() << "\n" <<
            this->player->GetMaxLevel()<< "\n" <<
            this->player->GetCurrentLevel() <<"\n";
        out.close();
    }
    emit SignalPlayerMainWindow(this->player);

}

void MainWindow::takeSignalMakeNewField(bool ans)
{
    qDebug() << "MainWindow::takeSignalMakeNewField()"<<Qt::endl;
    //this->ui->stackedWidget->setCurrentWidget(this->ui->menuPage);
    this->ui->startButton->animateClick();
}

void MainWindow::takePlayerOrSettings(bool choose)
{
    qDebug() << "MainWindow::takePlayerOrSettings()"<<Qt::endl;
    this->flag_player_or_settings = choose;
}

void MainWindow::PrintPlayer()
{
    qDebug() << "---";
    qDebug() << this->player->GetName();
    qDebug() << this->player->GetMaxLevel();
    qDebug() << this->player->GetCurrentLevel();
    qDebug() << "---";
}

