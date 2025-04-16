#include "computeritem.h"

ComputerItem::ComputerItem(
        const std::string& type_,
        const std::string& company_,
        const std::string& model_,
        const std::string& params_,
        double cost_,
        bool isInStore_) :
    type(type_),
    company(company_),
    model(model_),
    params(params_),
    cost(cost_),
    isInStore(isInStore_) {};

std::string ComputerItem::to_string() const {
    return type + " " + company + " " + model + " " + params + " " +
               std::to_string(cost) + " " + std::to_string(isInStore) + "\n";
}

void ReadFile(std::vector<ComputerItem>& items, const std::string fileName) {
    std::ifstream fin(fileName);
    ComputerItem item;
    while (fin >> item) {
        items.push_back(item);
    }

}

std::istream& operator>>(std::istream& in, ComputerItem& item) {
    std::string type;
    std::string company;
    std::string model;
    std::string params;
    double cost;
    bool isInStore;
    in >> type >> company >> model >> params >> cost >> isInStore;

    item = ComputerItem(type, company, model, params, cost, isInStore);

    return in;
}
std::ostream& operator<<(std::ostream& out, const ComputerItem& item) {
    return out;
}
