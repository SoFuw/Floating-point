#include<bitset>
#include<iostream>

int main(){
    std::bitset<8> bits_1("00000101");
    std::cout<<bits_1.to_string()<<std::endl;
    bits_1=std::bitset<8>("11111111");
    std::cout<<bits_1.to_string()<<std::endl;

}