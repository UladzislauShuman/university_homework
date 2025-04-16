#include "field.h"

Field::Field(QObject *parent): QObject{parent}
{}

Field::Field()
{
    qDebug() << "Field::Field()"<<Qt::endl;
    this->height = 3;
    this->width = 3;
    this->x1 = 0;this->y1 = 0;
    this->x2 = 0;this->y2 = 0;
}

Field::~Field()
{
    qDebug() << "Field::~Field()"<<Qt::endl;
    delete layout;
    for(int i = 0;i< field.size();i++){
        for(int j = 0;j < width;j++ ){
            delete field[i][j];
        }
        field[i].clear();
    }
    field.clear();
    cells_positions.clear();
    delete windialog;
    delete timer;
}

Field::Field(int width_, int height_,int attempts_):height(height_),width(width_),attempts(attempts_)
{
    this->timer = new QTimer();
    this->timer->setInterval(this->interval);
    connect(this->timer,SIGNAL(timeout()),this,SLOT(slotForTimer()));

    qDebug() << "Field::Field(int,int,int)"<<Qt::endl;
    this->x1 = 0;this->y1 = 0;
    this->x2 = 0;this->y2 = 0;
    emit SignalAttempts(this->attempts);

    if(width_ % 2 != 0 )
        this->width++;
    if(height_ % 2 != 0)
        this->height++;

    windialog = new WinDialog();
    connect(this,&Field::SignalTextMessage,windialog,&WinDialog::takeMessage);
    current_amount = 0;
    layout = new QGridLayout();
    amount_colored = 0;
    ///
    layout->setSpacing(2);
    layout->setContentsMargins(0, 0, 0, 0);
    ////
    for(int i = 0;i < this->height;i++){
        std::vector<Cell*> temp;
        this->field.push_back(temp);
        for(int j = 0;j < this->width;++j){
            field[i].push_back(new Cell(i,j));
            (*layout).addWidget(field[i][j],i,j);
            //сразу создаём одномерный массив с позициями клеток для дальнешего разуграшивания
            cells_positions.push_back(CellPosition(i,j));
            connect(field[i][j],&Cell::SignalPosition,this,&Field::takePos);
            connect(field[i][j],&Cell::SignalPosition,this,&Field::mainAlgorithm);
            //изменяем параметры SizePolicy
            field[i][j]->setMinimumSize(10,10);
            field[i][j]->setMaximumSize(75,75);
            field[i][j]->setSizePolicy(QSizePolicy(QSizePolicy::Expanding,QSizePolicy::Expanding));

        }
    }
    this->FillField();

    this->TurnAllOn();
    this->timer->start();
}

Field::Field(Player player_)
{
    this->timer = new QTimer();
    this->timer->setInterval(this->interval);
    connect(this->timer,SIGNAL(timeout()),this,SLOT(slotForTimer()));

    qDebug() << "Field::Field(Player)\n------"<<Qt::endl;
    this->x1 = 0;this->y1 = 0;
    this->x2 = 0;this->y2 = 0;
    qDebug() <<"player_.GetCurrentLevel = " << player_.GetCurrentLevel();
    this->width = player_.GetCurrentLevel()*2;
    this->height = player_.GetCurrentLevel()*2;
    this->attempts = this->width * this->height*2  ;
    emit SignalAttempts(this->attempts);

    int width_ = this->width;
    int height_ = this->height;
    if(width_ % 2 != 0 )
        this->width++;
    if(height_ % 2 != 0)
        this->height++;

    windialog = new WinDialog();
    connect(this,&Field::SignalTextMessage,windialog,&WinDialog::takeMessage);
    current_amount = 0;
    layout = new QGridLayout();
    amount_colored = 0;
    ///
    layout->setSpacing(2);
    layout->setContentsMargins(0, 0, 0, 0);
    ////
    for(int i = 0;i < this->height;i++){
        std::vector<Cell*> temp;
        this->field.push_back(temp);
        for(int j = 0;j < this->width;++j){
            field[i].push_back(new Cell(i,j));
            (*layout).addWidget(field[i][j],i,j);
            //сразу создаём одномерный массив с позициями клеток для дальнешего разуграшивания
            cells_positions.push_back(CellPosition(i,j));
            connect(field[i][j],&Cell::SignalPosition,this,&Field::takePos);
            connect(field[i][j],&Cell::SignalPosition,this,&Field::mainAlgorithm);
            //изменяем параметры SizePolicy
            field[i][j]->setMinimumSize(10,10);
            field[i][j]->setMaximumSize(75,75);
            field[i][j]->setSizePolicy(QSizePolicy(QSizePolicy::Expanding,QSizePolicy::Expanding));

        }
    }
    this->FillField();

    this->TurnAllOn();
    this->timer->start();
}

void Field::FillField()
{
    qDebug() << "Field::FillField()"<<Qt::endl;
    //std::vector<QColor> colors; // размер h*w/2
    //рассмотрим все числа на примере 6 на 6
    int cellSize = this->height*this->width; // 36
    int colorsAmount = cellSize / 2; // cellSize % 2 = 0 (гарантированно) // 18

    // Инициализируем генератор случайных чисел
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine engine(seed);

    //создадим std::set<QColor> из h*w/2 элементов
    //есть минус -- у set нет прямого доступа к элементу
    //поэтому -- пересоздадим в vector
    std::set<MyQColor> temp_colors;

    //почему не QColor?
    //проблема вознила с тем, что у QColor нет operator<
    while(temp_colors.size() < colorsAmount){
        int r = engine() % 256;
        int g = engine() % 256;
        int b = engine() % 256;
        MyQColor color(r, g, b);
        temp_colors.insert(color);
    }
    // пересоздаём вектор
    std::vector<MyQColor> colors;
    for(auto it = temp_colors.begin();it != temp_colors.end();it++){
        colors.push_back(*it);
    }

    // Перемешиваем элементы
    std::shuffle(this->cells_positions.begin(),this->cells_positions.end(),engine);
    //заполняем
    for(int i = 0;i < colors.size();i++){
        this->field[this->cells_positions[2*i].X()][this->cells_positions[2*i].Y()]->SetColor(colors[i].GetColor());
        //this->field[this->cells_positions[2*i].Y()][this->cells_positions[2*i].X()]->FillColor();

        this->field[this->cells_positions[2*i+1].X()][this->cells_positions[2*i+1].Y()]->SetColor(colors[i].GetColor());
        //this->field[this->cells_positions[2*i+1].Y()][this->cells_positions[2*i+1].X()]->FillColor();
    }

}

void Field::takePos(int x, int y)
{
    qDebug() << "Field::takePos(int,int)"<<Qt::endl;
    emit SignalXY_current(x,y);
}
void Field::mainAlgorithm(int x, int y)
{
    qDebug() << "Field::mainAlgorithm(int,int)"<<Qt::endl;
    if(this->field[x][y]->isWin() == true){
        qDebug() << "already win" << Qt::endl;
        return;
    }
    if(this->isFieldWin()){
        qDebug() << "you cant continue" << Qt::endl;
        return;
    }
////////////////////////////////////
    if(this->field[x][y]->Flag() == false){
        this->field[x][y]->FillColor();
        this->field[x][y]->setFlag(true);
        this->current_amount++;
        MyDebug(x,y,"Pressed");
    }else{
        if((this->CheckButton(x,y) == 1 or this->CheckButton(x,y) == 2) and this->current_amount == 2){
            return;
        }
        this->field[x][y]->SetNoColor();
        this->field[x][y]->setFlag(false);
        this->current_amount--;
        MyDebug(x,y,"unPressed");
    }
//////////////////////////////////////
    switch(this->current_amount){
    case 1:

        this->x1 = this->field[x][y]->X();
        this->y1 = this->field[x][y]->Y();
        break;
    case 2:

        this->x2 = this->field[x][y]->X();
        this->y2 = this->field[x][y]->Y();
        if(this->field[x1][y1]->GetColor() == this->field[x2][y2]->GetColor()){
            this->SetPareWin();
        }
        break;
    case 3:

        this->SetPareOff();
        this->x1 = this->field[x][y]->X();
        this->y1 = this->field[x][y]->Y();
        this->current_amount = 1;
        break;
    }

}



void Field::slotForTimer()
{
    this->TurnAllOff();
    this->timer->stop();
}

int Field::CheckButton(int x, int y)
{
    qDebug() << "Field::CheckButton(int,int)"<<Qt::endl;
    if(x == this->x1 and y == this->y1)
        return 1;
    if(x == this->x2 and y == this->y2)
        return 2;
    return 0;
}
//учесть, что в самом начале кнопки не прожаты
void Field::MyDebug(int y=-1, int x=-1, QString message="-1")
{
    qDebug() << "Field::MyDebug(int,int,QString)"<<Qt::endl;
    qDebug() << current_amount << " " << y <<" "<<x << " " << message;
    qDebug() << "1: "<<x1 << " " << y1 << " RGB: " << this->field[x1][y1]->GetColor().red() <<
            " " << this->field[x1][y1]->GetColor().blue() <<
            " " << this->field[x1][y1]->GetColor().green();
    qDebug() << "2: "<<x2 << " "<<y2 << " RGB: " << this->field[x2][y2]->GetColor().red() <<
        " " << this->field[x2][y2]->GetColor().blue() <<
        " " << this->field[x2][y2]->GetColor().green();

    qDebug() << Qt::endl;
}

void Field::SetPareWin()
{
    qDebug() << "Field::SetPareWin()"<<Qt::endl;
    this->field[x1][y1]->setWin(true);
    this->field[x2][y2]->setWin(true);
    amount_colored += 2;
    //пересмотрим проверку
    if(this->amount_colored == (this->height*this->width))
        this->isFieldWin();
    //this->windialog->show();
}

void Field::SetPareOff()
{
    qDebug() << "Field::SetPareOff()"<<Qt::endl;
    if(this->field[x1][y1]->isWin() == false and this->field[x2][y2]->isWin() == false)
    {
        this->field[x1][y1]->SetNoColor();
        this->field[x1][y1]->setFlag(false);
        this->field[x2][y2]->SetNoColor();
        this->field[x2][y2]->setFlag(false);

        this->attempts--;
        emit SignalAttempts(this->attempts);
        if(this->attempts == 0)
            this->isFieldWin();
    }
}

bool Field::isFieldWin()
{
    qDebug() << "Field::isFieldWin()"<<Qt::endl;
    //пока пусть работает так
    if(amount_colored == (this->height*this->width)){
        emit SignalTextMessage("Победа!",true);
        this->windialog->show();
        return true;
    }
    else{
        if(this->attempts == 0){
            emit SignalTextMessage("Провал :(",false);
            this->windialog->show();
            return true;
        }
    }
    return false;
}

void Field::TurnAllOn()
{
    qDebug() << "Field::TurnAllOn()"<<Qt::endl;
    for(int i = 0;i < this->height;++i){
        for(int j = 0;j < this->width;j++){
            this->field[i][j]->FillColor();
        }
    }
}

void Field::TurnAllOff()
{
    qDebug() << "Field::TurnAllOff()"<<Qt::endl;
    for(int i = 0;i < this->height;++i){
        for(int j = 0;j < this->width;j++){
            this->field[i][j]->SetNoColor();
        }
    }
}


