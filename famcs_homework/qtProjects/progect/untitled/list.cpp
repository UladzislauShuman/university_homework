#include "list.h"

List::List() {
    head = nullptr;
}

List::List(int value) {
    head = new SElement(value, nullptr);
}

List::List(int value1, int value2, int value3) {
    head = new SElement(value1, new SElement(value2, new SElement(value3, nullptr)));
}

List::~List() {
    while (head != nullptr) {
        removeFirst();
    }
}

void List::print() {
   
}

bool List::isEmpty() const {
    return head == nullptr;
}

void List::prepend(int value) {
    SElement* newElement = new SElement(value, head);
    head = newElement;
}

int List::removeFirst() {
    int result = head->data;
    SElement* nextElement = head->next;
    delete head;
    head = nextElement;
    return result;
}

std::vector<int> List::toVector() const {
    std::vector<int> vectorList;
    for (SElement* current = head; current != nullptr; current = current->next) {
        vectorList.push_back(current->data);
    }
    return vectorList;
}
