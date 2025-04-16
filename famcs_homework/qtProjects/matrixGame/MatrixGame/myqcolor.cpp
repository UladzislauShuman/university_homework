#include "myqcolor.h"

bool operator<( const MyQColor A,const MyQColor B){
    //qDebug() << "MyQColor::operator<()"<<Qt::endl;
    return A.color.name() < B.color.name();
}

bool operator==( const MyQColor A,const MyQColor B){
    //qDebug() << "MyQColor::operator==()"<<Qt::endl;
    return A.color.name() == B.color.name();
}
