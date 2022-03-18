#ifndef UTILITY_H
#define UTILITY_H
#include <math.h>
#include <QString>
#include <QDebug>

int digitsAfterDecimal(double);


int digitsAfterDecimal(double v){
    double minus = v - std::floor(v);
    if(minus == 0)
        return 0;
    else{
        QString s = QString::number(minus, 'g', 8);
        return s.length() - 2;
    }
}
#endif // UTILITY_H
