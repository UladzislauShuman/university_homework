#ifndef RADIOITEM_H
#define RADIOITEM_H
/*
Каждый пункт содержит следующую информацию:
 - наименование группы изделий
(телевизор, радиотелефон и т. п.),
- марка изделия,
- дата приемки в ремонт,
- дата исполнения заказа,
- состояние готовности заказа (выполнен или не выполнен).
 */
#include <string>
#include <vector>
#include <fstream>

class radioitem
{
public:
    radioitem() = default;
    ~radioitem() = default;
    radioitem(
        const std::string& type_,
        const std::string& company_,
        const std::string& dateStart_,
        const std::string& dateEnd_,
        const bool& isDone_);

    //get-tery
    std::string Type()const {return this->type;}
    std::string Company()const {return this->company;}
    std::string DateStart()const {return this->dateStart;}
    std::string DateEnd()const {return this->dateEnd;}
    bool IsDone()const {return isDone;}

    //методы
    std::string to_string();

    friend bool DateEndCompare(const radioitem& a,const radioitem& b);
private:
    std::string type;
    std::string company;
    std::string dateStart;
    std::string dateEnd;
    bool isDone;
};
std::istream& operator>>(std::istream&,radioitem&);
std::ostream& operator<<(std::ostream&,radioitem&);
void ReadFile(std::vector<radioitem>&, const std::string);
#endif // RADIOITEM_H
