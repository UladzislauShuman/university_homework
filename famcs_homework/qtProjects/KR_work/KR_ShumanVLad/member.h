#ifndef MEMBER_H
#define MEMBER_H

#include <iostream>
#include <fstream>
#include <string>

class Member
{
public:
    Member();
    Member(std::string name_,int score_):name(name_),score(score_){}
    std::string to_string();
    friend std::istream& operator>>(std::istream&, Member&);
    friend std::ostream& operator<<(std::ostream&, Member&);
    friend bool operator <(Member&,Member&);

    std::string GetName();
    int GetScore();
private:
    std::string name;
    int score;
};

#endif // MEMBER_H
