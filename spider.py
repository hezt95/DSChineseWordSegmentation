#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

import urllib.request
import urllib
import re
from bs4 import BeautifulSoup


def getContent(url):
        # get one url's all content
    html = urllib.request.urlopen(url).read()
    # use bs4 to get the text
    soup = BeautifulSoup(html, 'html.parser')
    soupP = soup.find_all('p')
    resultList = []
    for item in soupP:
        resultList.append(str(item.get_text()))
    resultStr = ''.join(resultList)
    global content, counterContent
    print('INFO   Getting No.%d article. URL:%s' % (counterContent, url))
    counterContent += 1
    content += '\n\n\n'
    content += re.sub(r'\s+', ' ', resultStr)
    # sys.stdout.buffer.write(data)


def getArticleUrl(parentUrl):
        # get article urt from collections web
    html = urllib.request.urlopen(parentUrl).read()
    soup = BeautifulSoup(html, 'html.parser')
    soupH4 = soup.find_all('h4')
    linkPattern = re.compile(r'^/p/')
    global articleList, counterArticle
    print('INFO   Getting article\'s %d URL form collections.' %
          counterArticle)
    counterArticle += 1
    for link in soupH4:
        if link.a:
            match = linkPattern.match(link.a['href'])
            if match:
                url = 'http://www.jianshu.com' + match.string
                articleList.append(url)


def getCollectionsUrl():
        # collections order score(hot or not)
    unfinshParentUrl = \
        'http://www.jianshu.com/collections?order_by=score&page='
    # loop for 10 times in order to get 10 pages' collections' url
    for x in range(1, 11):
        # finish the parent url
        parentUrl = unfinshParentUrl + str(x)
        html = urllib.request.urlopen(parentUrl).read()
        soup = BeautifulSoup(html, 'html.parser')
        soupH5 = soup.find_all('h5')
        linkPattern = re.compile(r'^/collection/')
        global collectionsList
        print('INFO   Getting Page %d collections.' % x)
        for link in soupH5:
            if link.a:
                match = linkPattern.match(link.a['href'])
                url = 'http://www.jianshu.com' + match.string
                collectionsList.append(url)


def main():
    getCollectionsUrl()
    for collectionUrl in collectionsList:
        getArticleUrl(collectionUrl)
    for articleUrl in articleList:
        getContent(articleUrl)
    f = open('content', 'w')
    print('INFO:Saving...')
    f.write(content)
    f.close()

collectionsList = []
articleList = []
content = ''
counterContent = 1
counterArticle = 1
if __name__ == '__main__':
    main()
