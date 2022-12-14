#include <iostream>
#include <cstring>
#include <fstream>
#include <string>
#include <bitset>
const unsigned int CASE_NUM = 1024;
int main()
{

    std::ifstream readFile;
    std::ofstream writeFile;
    std::string buf_str[3];
    std::bitset<32> buf_bits[3];
    float f_vals[3];
    float res;
    unsigned long ul_vals[3];

    unsigned long ul_res;
    std::bitset<32> res_bits;
    std::string res_str;
    readFile.open("f_multiplier_log.txt");
    writeFile.open("f_multiplier_check.txt");
    int ulpcnt = 0;
    int cnt = 0;
    while ((!readFile.eof()))
    {
        // read in0,in1,carry,out
        for (int i = 0; i < 3; i++)
        {
            std::getline(readFile, buf_str[i]);
            if (buf_str[i] == "quit!")
            {
                std::cout << "done" << std::endl;
                break;
            }
            // sign exp signi
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
        std::string line = "in0 : " + std::to_string(f_vals[0]) + '\n';
        line += "in1 : " + std::to_string(f_vals[1]) + '\n';
        line += "res : " + res_str + '\n';
        line += "buf : " + buf_str[2] + '\n';
        std::cout << "in0 : " << f_vals[0] << std::endl;
        std::cout << "in1 : " << f_vals[1] << std::endl;
        std::cout << "res : " << res_str << std::endl;
        std::cout << "buf : " << buf_str[2] << std::endl;
        std::string buf_str_ulp = buf_str[2];
        std::string buf_str_ulp2 = buf_str[2];
        buf_str_ulp[31] = '0';
        buf_str_ulp2[31] = '1';
        if (buf_str[2] == res_str)
        {
            std::cout << "same!!" << std::endl;
            line += "same!\n";
            cnt++;
        }
        else if (buf_str_ulp2 == res_str)
        {
            std::cout << "ulp2 case !!" << std::endl;
            line += "ulp2 case!\n";
            ulpcnt++;
        }
        else if (buf_str_ulp == res_str)
        {
            std::cout << "ulp1 case !!" << std::endl;
            line += "ulp1 case!\n";
            ulpcnt++;
        }
        else
        {
            std::cout << "differ!" << std::endl;
            line += "differ!\n";
        }
        writeFile.write(line.c_str(), line.size());
    }
    std::cout << "cnt is : " << cnt << std::endl;
    std::string endline = "cnt is : " + std::to_string(cnt) + "\n";
    std::cout << "ulp is : " << ulpcnt << std::endl;
    endline += "ulp is : " + std::to_string(ulpcnt) + "\n";
    writeFile.write(endline.c_str(), endline.size());

    return 0;
}