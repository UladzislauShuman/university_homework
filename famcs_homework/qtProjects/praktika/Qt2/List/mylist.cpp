#include "mylist.h"

template<class T>
MyList<T>::MyList(const std::initializer_list<T>& list) :MyList()
{
    for (T i : list)
    {
        this->push_back(i);
    }
}

template<class T>
    void MyList<T>::push_back(const T& key)
{
    SElement* temp = new SElement(key, nullptr);
    if (this->size == 0)
    {
        this->head = temp;
    }
    else
    {
        this->tail->next = temp;
    }
    this->tail = temp;
    this->size++;
}

template<class T>
void MyList<T>::push_front(const T& element)
{
    SElement* temp = new SElement(element, this->head);
    if (this->size == 0)
    {
        this->tail = temp;
    }
    // else
    // {
    //     this->head->prev = temp;
    // }
    this->head = temp;
    this->size++;
}

template<class T>
MyList<T>::MyList() :size(0), head(nullptr), tail(nullptr) {}

template<class T>
MyList<T>::~MyList()
{
    while (this->size)
    {
        this->pop_back();
    }
}

template<class T>
T MyList<T>::pop_back()
{
    SElement* Temp = this->tail;
    T ReturnValue = this->tail->data;
    if (this->size == 0)
    {
        std::cout << "Error : list is empty\n";
        return T();
    }
    if (this->size == 1)
    {
        this->head = nullptr;
        this->tail = nullptr;
    }
    else
    {
        this->tail = Temp->prev;
        tail->next = nullptr;
    }
    delete Temp;
    size--;
    return ReturnValue;
}

template<class T>
T MyList<T>::pop_front()//////////////////////////////
{
    SElement* Temp = this->head;
    T ReturnValue = this->head->data;
    if (this->size == 0)
    {
        std::cout << "Error : list is empty\n";
        return T();
    }
    if (this->size == 1)
    {
        this->head = nullptr;
        this->tail = nullptr;
    }
    else
    {
        this->head = Temp->next;
        this->head->prev = nullptr;
    }
    delete Temp;
    size--;
    return ReturnValue;
}

template<class T>//////////////////////////
void MyList<T>::insert(const T& element, size_t index)
{

    SElement* temp = this->head;

    if (index > this->getSize() or index < 0)
    {
        std::cout << "wrong index"<<std::endl;
        return;
    }

    if (index == 0)
    {
        this->push_front(element);
        return;
    }

    if (index = this->getSize())
    {
        this->push_back(element);
        return;
    }

    for (int i = 0; i < index; i++) {
        temp = temp->next;
    }
    SElement* El = new SElement(element, temp->prev, temp);
    temp->prev->next = El;
    temp->prev = El;
    this->size++;

}

template<class T>///////////////////////////////////////
    void MyList<T>::remove(const T& element)
{

    SElement* temp = this->head;
    int i = 0;

    while (i < this->getSize())
    {

        if (element == temp->data)
        {
            if (i == 0)
            {
                this->pop_front();
                temp = this->head;
                continue;
            }

            if (temp == this->tail and element == this->tail->data)
            {
                this->pop_back();
                break;
            }

            SElement* tPrev = temp->prev;
            SElement* tNext = temp->next;
            tNext->prev = tPrev;
            tPrev->next = tNext;
            temp = temp->next;
            this->size--;
        }
        else {
            temp = temp->next;
            i++;
        }

    }
}

template<class T>
void MyList<T>::print()
{
    if (this->size == 0) {
        std::cout << "null" << std::endl;
        return;
    }
    for (MyList<int>::Iterator it = this->Begin(); it != this->End(); it++)
    {
        std::cout << *it << " ";
    }
    std::cout << '\n';
}

// template<class T>
// void MyList<T>::rshow()
// {
//     if (this->size == 0) {
//         std::cout << "null" << std::endl;
//         return;
//     }
//     for (MyList<int>::rIterator it = this->rBegin(); it != this->rEnd(); ++it) {
//         std::cout << *it << " ";
//     }
//     std::cout << std::endl;
// }


