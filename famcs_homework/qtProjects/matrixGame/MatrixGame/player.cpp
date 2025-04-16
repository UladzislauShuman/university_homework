#include "player.h"


Player::Player(Player& player_)
{
    //qDebug() << "Player::Player(Player&)"<<Qt::endl;
    this->Name = player_.Name;
    this->max_level = player_.max_level;
    this->current_level = player_.current_level;
}
