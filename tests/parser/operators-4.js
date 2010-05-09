/*
value = (a or (b and (c | (d ^ (e & f)))))
value = (((((a & b) ^ c) | d) and e) or f)
*/

value = a || b && c | d ^ e & f;
value = a & b ^ c | d && e || f;
