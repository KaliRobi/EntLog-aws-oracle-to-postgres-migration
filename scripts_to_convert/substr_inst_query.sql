select destination, 
substr(destination, 1, instr(destination, ' ') - 1) as first_word, 
substr(destination, instr(destination, ' ') + 1) as remaining_words
from deliveries
where instr(destination, ' ') > 0;
