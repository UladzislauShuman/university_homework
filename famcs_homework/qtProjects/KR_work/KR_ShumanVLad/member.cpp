#include "member.h"

Member::Member() {}

std::string Member::to_string()
{
    return this->name + " " + std::to_string(this->score);
}

std::string Member::GetName(){return this->name;}

int Member::GetScore(){return this->score;}

std::istream& operator>>(std::istream& in, Member& member)
{
    in >> member.name >> member.score;
    return in;
}
std::ostream& operator<<(std::ostream& out, Member& member)
{
    out << member.name << " " << member.score;
    return out;
}

