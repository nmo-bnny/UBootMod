#include <command.h>



/*
 * Demonstration code showing how a command can be executed
 * during the boot process in U-Boot.
 *
 * This example is for educational and security research purposes
 * only, to illustrate why boot-time access must be protected.
*/

static int bootkit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]) {
    printf("\n🐇\n");
    printf("\n🐇\n");
    printf("\n🐇\n");
    return 0;


}



U_BOOT_CMD(

bootkit, 2, 0, bootkit, "message displayed on boot to simulate malicious code", "none"

);




int board_late_init(void)
{
    bootkit(NULL, 0, 0, NULL);
    return 0;
}
