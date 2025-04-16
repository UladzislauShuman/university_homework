#include "radioitem.h"
#include <sstream>

radioitem::radioitem(
    const std::string& type_,
    const std::string& company_,
    const std::string& dateStart_,
    const std::string& dateEnd_,
    const bool& isDone_):type(type_),company(company_),dateStart(dateStart_),dateEnd(dateEnd_),isDone(isDone_){}
std::istream& operator>>(std::istream& in,radioitem& item)
{
    std::string type;
    std::string company;
    std::string dateStart;
    std::string dateEnd;
    bool isDone;

    in >> type >> company >> dateStart >> dateEnd >> isDone;
    item = radioitem(type,company,dateStart,dateEnd,isDone);
    return in;
}
//
std::ostream& operator<<(std::ostream&,radioitem&);

void ReadFile(std::vector<radioitem>& radioitems, const std::string fileName)
{
    std::ifstream fin(fileName);
    radioitem item;
    while(fin >> item)
    {
        radioitems.push_back(item);
    }
}

std::string radioitem::to_string()
{
    return type + " " + company + " " + dateStart + " " + dateEnd + " " + std::to_string(isDone)+"\n";
}

//функия для сравнения дат a<b
bool DateEndCompare(const radioitem& a,const radioitem& b)
{
    std::string dateA = a.DateEnd();
    std::string dateB = b.DateEnd();

    int dayA,monthA,yearA,
        dayB,monthB,yearB;
    char dot;
    std::istringstream inA(dateA);
    inA >> dayA >> dot >> monthA >> dot >> yearA;

    std::istringstream inB(dateB);
    inB >> dayB >> dot >> monthB >> dot >> yearB;

    bool ans = true;
    if(yearB > yearA)
        return ans;
    else {
        if(yearB == yearA){
            if(monthB > monthA)
                return ans;
            else {
                if(monthB == monthA){
                    if(dayB > dayA)
                        return ans;
                    else
                        return !ans;
                }
                else
                    return !ans;
            }
        }
        else
            return !ans;
    }
    return true;
}

