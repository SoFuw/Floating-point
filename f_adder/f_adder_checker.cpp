#include <iostream>
#include <fstream>
#include <cstdio>
#include <string>
#include <cstring>
#include <bitset>
#include <vector>
// https://stackoverflow.com/questions/7533795/using-bitset-with-floating-types
// bits->float->cal->bits->check...

// 0은 더하기 1은 빼기
int main()
{
    std::ifstream readFile;
    std::ofstream writeFile;
    std::string print_str;
    std::vector<std::string> str_vec;
    std::string buf_str;
    std::bitset<32> buf_bits;
    readFile.open("f_adder_log.txt");
    writeFile.open("f_adder_log_for_me.txt");
    bool op = false;
    unsigned long in0 = 0, in1 = 0, c_out = 0, check_bits = 0;
    float f_in0 = 0.0, f_in1 = 0.0, f_out = 0.0, f_compared = 0.0;

    // log 가공..
    while (!readFile.eof())
    {
        std::getline(readFile, buf_str);
        if (buf_str[0] != '\n')
            str_vec.push_back(buf_str);
    }
    for (int i = 0; i < str_vec.size() - 4; i += 4)
    {
        str_vec[3 + i].assign(str_vec[7 + i]);
    }
    for (int i = 0; i < 5; i++)
        str_vec.pop_back();
    // for (std::string &str : str_vec)
    // {
    //     std::cout << str << std::endl;
    // }
    for (int i = 0; i < str_vec.size(); i += 4)
    {
        op = (str_vec[i][0] == '0') ? false : true;
        buf_bits = std::bitset<32>(str_vec[i + 1]);

        in0 = buf_bits.to_ulong();
        buf_bits = std::bitset<32>(str_vec[i + 2]);
        in1 = buf_bits.to_ulong();
        buf_bits = std::bitset<32>(str_vec[i + 3]);
        c_out = buf_bits.to_ulong();
        memmove(&f_in0, &in0, sizeof(float));
        memmove(&f_in1, &in1, sizeof(float));
        memmove(&f_compared, &c_out, sizeof(float));
        if (!op)
            f_out = f_in0 + f_in1;
        else
            f_out = f_in0 - f_in1;
        memmove(&check_bits, &f_out, sizeof(float));
        buf_bits = std::bitset<32>(check_bits);
        std::cout << "op : " << str_vec[i] << std::endl;
        std::cout << "check : " << op << std::endl;
        std::cout << "in0 : " << str_vec[i + 1] << std::endl;
        std::cout << "float : " << f_in0 << std::endl;
        std::cout << "ul : " << in0 << std::endl;
        std::cout << "in1 : " << str_vec[i + 2] << std::endl;
        std::cout << "float : " << f_in1 << std::endl;
        std::cout << "ul : " << in1 << std::endl;
        std::cout << "my cal.. : " << f_compared << std::endl;
        std::cout << "bits.. :" << str_vec[i + 3] << std::endl;
        std::cout << "machine cal.. : " << f_out << std::endl;
        std::cout << "bits.. :" << buf_bits.to_string() << std::endl;

        if (f_compared == f_out)
            std::cout << "same!!" << std::endl;
        else
            std::cout << "diff" << std::endl;
        std::cout << "\n\n";
    }
}

//드디어 성공.. memmove... 이용