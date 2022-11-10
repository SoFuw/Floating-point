#include <iostream>
#include <fstream>
#include <string>
#include <cstring>
#include <vector>

int main(int argc, char *argv[])
{
    std::ifstream readFile;
    readFile.open("f_comparator_log.txt");
    std::string buf_str;
    std::vector<std::string> str_vector(4);
    int checker = 0;
    // 0->cnt 1->in0 2->in1 3->out
    char *buf1;
    char *buf2;
    while (!readFile.eof())
    {
        for (std::string &str : str_vector)
            // read cnt in0 in1 out...
            std::getline(readFile, str);

        buf1 = new char[str_vector[1].length() + 1];
        std::strcpy(buf1, str_vector[1].c_str());
        buf2 = new char[str_vector[2].length() + 1];
        std::strcpy(buf2, str_vector[2].c_str());
        
        for (int i = 1; i < 32; i++)
        {
            if (buf1[i] > buf2[i]){
                checker = 1;
                break;
            }else if(buf1[i]==buf2[i]) 
                continue;
            else{
                checker = 0;
                break;
            }
        }
   

        delete[] buf1;
        delete[] buf2;

        // std::cout << "output0.. : " + str_vector[0] << std::endl;
        // std::cout << "output1.. : " + str_vector[1] << std::endl;
        // std::cout << "output2.. : " + str_vector[2] << std::endl;
        // std::cout << "output3.. : " + str_vector[3] << std::endl;
        // std::cout <<"haha::"<< (checker) << std::endl;
     


        if ((checker) == std::atoi(str_vector[3].c_str()))
        {
            std::cout << "Correct" << std::endl;
        }
        else
            std::cout << "Wrong!" << std::endl;
    }
    readFile.close();
}

// 2022-11-09