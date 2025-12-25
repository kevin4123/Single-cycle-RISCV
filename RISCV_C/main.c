#define led_base 0xffff0010
#define timer_base 0xffff0000
#define button_base 0xffff0020
#define disp_base 0xffff8000
#define term_base 0xffff0030


int main() {
        int i = 1;

        for(;;){
            volatile int a = 10;
            *((volatile int *)led_base) = i;
            while(a--){};

            i = i << 1;
            if(i > 0x80) 
                i = 1;
        }
}
