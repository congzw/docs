## crome console 获取所有连接的href，作为数组返回

[].slice.call(jQuery('table#ed2k tr td a')).map(el => el.getAttribute('href'))
