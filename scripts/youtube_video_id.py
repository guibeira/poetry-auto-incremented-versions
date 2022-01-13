import re

regex = r"(https?:\/\/)?((www\.)?(youtube(-nocookie)?|youtube.googleapis)\.com.*(v\/|v=|vi=|vi\/|e\/|embed\/|user\/.*\/u\/\d+\/)|youtu\.be\/)(.+)"
changes = open('CHANGES.rst', 'r')
changes_content =  changes.read()

matches = re.search(regex, changes_content)
if matches:
    print(matches.group(7))

