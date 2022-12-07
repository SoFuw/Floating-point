#include <iostream>
#include <cstring>
#include <fstream>
#include <string>
#include <bitset>
constexpr unsigned int BIT_WIDTH = 8;
int main()
{

    std::ifstream readFile;
    std::string buf_str[4];
    std::bitset<32> buf_bits[4];
    float f_vals[4];
    float res;
    unsigned long ul_vals[4];

    unsigned long ul_res;
    std::bitset<32> res_bits;
    std::string res_str;
    readFile.open("mantissa_multiplier_log.txt");
    int cnt = 0;
    while ((!readFile.eof()))
    {
        // read in0,in1,carry,out
        for (int i = 0; i < 4; i++)
        {
            std::getline(readFile, buf_str[i]);
            // sign exp signi
            buf_str[i] = "0" + (std::string) "01111111" + buf_str[i] + "00000000000000000000";
            buf_bits[i] = std::bitset<32>(buf_str[i]);
            ul_vals[i] = buf_bits[i].to_ulong();
            std::memmove(&f_vals[i], &ul_vals[i], sizeof(float));
        }

        res = f_vals[0] * f_vals[1];
        std::memmove(&ul_res, &res, sizeof(float));
        res_bits = std::bitset<32>(ul_res);
        res_str = res_bits.to_string();
        // res_str=res_str.substr(9,16);
        // buf_str[3]=buf_str[3].substr(9,16);
        std::cout << "in0 : " << f_vals[0] << std::endl;
        std::cout << "in1 : " << f_vals[1] << std::endl;
        buf_str[3]=buf_str[3].substr(9,BIT_WIDTH);
        res_str=res_str.substr(9,BIT_WIDTH);
        std::cout << "res : " << res_str << std::endl;
        std::cout << "buf : " << buf_str[3]
                  << std::endl;
        if (buf_str[3] == res_str)
        {
            std::cout << "same!!" << std::endl;
            cnt++;
        }else {
            std::cout<<"differ!"<<std::endl;
        }
    }
    std::cout << "cnt is : " << cnt << std::endl;

    return 0;
}