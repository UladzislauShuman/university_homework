#ifndef PLAYER_H
#define PLAYER_H

#include <QDebug>

#include <string>

class Player
{
public:
    Player():Name("Noname"),max_level(0),current_level(0){
        //qDebug() << "Player::Player()"<<Qt::endl;
    }
    Player(Player&);
    void SetName(std::string Name_){
        //qDebug() << "Player::Setname(std::string)"<<Qt::endl;
        this->Name = Name_;}
    std::string GetName(){
        //qDebug() << "Player::GetName()"<<Qt::endl;
        return this->Name;}

    void SetMaxLevel(int max_level_){
        //qDebug() << "Player::SetMaxLevel()"<<Qt::endl;
        this->max_level = max_level_;}
    int GetMaxLevel(){
        //qDebug() << "Player::GetMaxLevel()"<<Qt::endl;
        return this->max_level;}

    void SetCurrentLevel(int current_level_){
        //qDebug() << "Player::SetCurrentLevel()"<<Qt::endl;
        this->current_level = (current_level_ == 0)? 1 : current_level_;}
    int GetCurrentLevel(){
        //qDebug() << "Player::GetCurrentLevel()"<<Qt::endl;
        return this->current_level;}
private:
    std::string Name;
    int max_level;
    int current_level;
};

#endif // PLAYER_H
