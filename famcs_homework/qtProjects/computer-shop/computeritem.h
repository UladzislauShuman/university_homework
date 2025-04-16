#ifndef COMPUTERITEM_H
#define COMPUTERITEM_H

#include <string>
#include <vector>
#include <fstream>

class ComputerItem
{
public:
    ComputerItem() = default;
    ~ComputerItem() = default;
    ComputerItem(
            const std::string& type_,
            const std::string& company_,
            const std::string& model_,
            const std::string& params_,
            double cost_,
            bool isInStore_);

    std::string Type() const {return type;}
    std::string Company() const {return company;}
    std::string Model() const {return model;}
    std::string Params() const {return params;}
    double Cost() const {return cost;}
    bool IsInStore() const {return isInStore;}

    std::string to_string() const;

private:
    std::string type;
    std::string company;
    std::string model;
    std::string params;
    double cost;
    bool isInStore;
};

std::istream& operator>>(std::istream&, ComputerItem&);
std::ostream& operator<<(std::ostream&, const ComputerItem&);
void ReadFile(std::vector<ComputerItem>&, const std::string);

#endif // COMPUTERITEM_H
