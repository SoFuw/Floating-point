#include<iostream>
#include<fstream>
#include<string>


int main(int argc,char* argv[]){
    std::ifstream readFile;
    readFile.open("f_comparator_log.txt");
    std::string str;
    while (!readFile.eof())
    {
        std::getline(readFile,str);
        std::cout << str << std::endl;
    }
    readFile.close();
    
    
    
}