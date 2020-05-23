# 2019-11-26

import re
import sys
def replace(file_name, output_file_name):
    try:
        pattern1 = r"\$\$\n*([\s\S]*?)\n*\$\$"
        new_pattern1 = r'\n<img src="https://www.zhihu.com/equation?tex=\1" alt="\1" class="ee_img tr_noresize" eeimg="1">\n'
        pattern2 = r"\$\n*(.*?)\n*\$"
        new_pattern2 =r'<img src="https://www.zhihu.com/equation?tex=\1" alt="\1" class="ee_img tr_noresize" eeimg="1">'
        f = open(file_name, 'r', encoding='utf-8')
        f_output = open(output_file_name, 'w', encoding='utf-8')
        all_lines = f.read()
        new_lines1 = re.sub(pattern1, new_pattern1, all_lines)
        new_lines2 = re.sub(pattern2, new_pattern2, new_lines1)
        f_output.write(new_lines2)

        f.close()
        f_output.close()
    except Exception as e:
        print(e)


if __name__ == '__main__':
    file_name = './doc/original_version.md'
    file_name_pre = file_name.split(".")[0]
    output_file_name = "./zhihu_doc/zhihu_version.md"
    replace(file_name, output_file_name)
    print('Trans from {} to {}'.format(file_name, output_file_name))