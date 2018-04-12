
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <print_ticks_as_seconds>:
#define MAX 64
#define PSHEADER "\nPID\tUID\tGID\tPPID\tELAPSED\tCPU\tSTATE\tSIZE\tNAME\n"

void
print_ticks_as_seconds(uint milliseconds)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  uint integer_part = milliseconds / 1000;
   6:	8b 45 08             	mov    0x8(%ebp),%eax
   9:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
   e:	f7 e2                	mul    %edx
  10:	89 d0                	mov    %edx,%eax
  12:	c1 e8 06             	shr    $0x6,%eax
  15:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint fractional_part = milliseconds % 1000;
  18:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1b:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  20:	89 c8                	mov    %ecx,%eax
  22:	f7 e2                	mul    %edx
  24:	89 d0                	mov    %edx,%eax
  26:	c1 e8 06             	shr    $0x6,%eax
  29:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  2f:	29 c1                	sub    %eax,%ecx
  31:	89 c8                	mov    %ecx,%eax
  33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  printf(1, "%d.", integer_part);
  36:	83 ec 04             	sub    $0x4,%esp
  39:	ff 75 f4             	pushl  -0xc(%ebp)
  3c:	68 6c 0b 00 00       	push   $0xb6c
  41:	6a 01                	push   $0x1
  43:	e8 6d 07 00 00       	call   7b5 <printf>
  48:	83 c4 10             	add    $0x10,%esp
  if(fractional_part < 10) 
  4b:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  4f:	77 14                	ja     65 <print_ticks_as_seconds+0x65>
    printf(1, "00");
  51:	83 ec 08             	sub    $0x8,%esp
  54:	68 70 0b 00 00       	push   $0xb70
  59:	6a 01                	push   $0x1
  5b:	e8 55 07 00 00       	call   7b5 <printf>
  60:	83 c4 10             	add    $0x10,%esp
  63:	eb 18                	jmp    7d <print_ticks_as_seconds+0x7d>
  else if(fractional_part < 100)
  65:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  69:	77 12                	ja     7d <print_ticks_as_seconds+0x7d>
    printf(1, "0");
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	68 73 0b 00 00       	push   $0xb73
  73:	6a 01                	push   $0x1
  75:	e8 3b 07 00 00       	call   7b5 <printf>
  7a:	83 c4 10             	add    $0x10,%esp
  printf(1, "%d", fractional_part);
  7d:	83 ec 04             	sub    $0x4,%esp
  80:	ff 75 f0             	pushl  -0x10(%ebp)
  83:	68 75 0b 00 00       	push   $0xb75
  88:	6a 01                	push   $0x1
  8a:	e8 26 07 00 00       	call   7b5 <printf>
  8f:	83 c4 10             	add    $0x10,%esp
}
  92:	90                   	nop
  93:	c9                   	leave  
  94:	c3                   	ret    

00000095 <main>:

int
main(void)
{
  95:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  99:	83 e4 f0             	and    $0xfffffff0,%esp
  9c:	ff 71 fc             	pushl  -0x4(%ecx)
  9f:	55                   	push   %ebp
  a0:	89 e5                	mov    %esp,%ebp
  a2:	56                   	push   %esi
  a3:	53                   	push   %ebx
  a4:	51                   	push   %ecx
  a5:	81 ec 1c 0e 00 00    	sub    $0xe1c,%esp
    int i;
    int nprocesses;
    struct uproc table[MAX];

    nprocesses = getprocs(MAX, &table[0]);
  ab:	83 ec 08             	sub    $0x8,%esp
  ae:	8d 85 e0 f1 ff ff    	lea    -0xe20(%ebp),%eax
  b4:	50                   	push   %eax
  b5:	6a 40                	push   $0x40
  b7:	e8 1a 06 00 00       	call   6d6 <getprocs>
  bc:	83 c4 10             	add    $0x10,%esp
  bf:	89 45 e0             	mov    %eax,-0x20(%ebp)

    if(nprocesses < 0) {
  c2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  c6:	79 17                	jns    df <main+0x4a>
        printf(1, "ERROR: unable to construct Process Table\n");
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	68 78 0b 00 00       	push   $0xb78
  d0:	6a 01                	push   $0x1
  d2:	e8 de 06 00 00       	call   7b5 <printf>
  d7:	83 c4 10             	add    $0x10,%esp
        exit();
  da:	e8 1f 05 00 00       	call   5fe <exit>
    }

    printf(1, PSHEADER);    
  df:	83 ec 08             	sub    $0x8,%esp
  e2:	68 a4 0b 00 00       	push   $0xba4
  e7:	6a 01                	push   $0x1
  e9:	e8 c7 06 00 00       	call   7b5 <printf>
  ee:	83 c4 10             	add    $0x10,%esp

    for(i = 0; i < nprocesses; i++) {
  f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  f8:	e9 c3 01 00 00       	jmp    2c0 <main+0x22b>
        if(table[i].pid == 0)
  fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 100:	89 c2                	mov    %eax,%edx
 102:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 109:	89 c2                	mov    %eax,%edx
 10b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 112:	29 d0                	sub    %edx,%eax
 114:	8d 5d e8             	lea    -0x18(%ebp),%ebx
 117:	01 d8                	add    %ebx,%eax
 119:	2d 08 0e 00 00       	sub    $0xe08,%eax
 11e:	8b 00                	mov    (%eax),%eax
 120:	85 c0                	test   %eax,%eax
 122:	0f 84 a6 01 00 00    	je     2ce <main+0x239>
            break;
        printf(1, "%d\t%d\t%d\t%d\t", table[i].pid, table[i].uid, table[i].gid, table[i].ppid);
 128:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 12b:	89 c2                	mov    %eax,%edx
 12d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 134:	89 c2                	mov    %eax,%edx
 136:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 13d:	29 d0                	sub    %edx,%eax
 13f:	8d 75 e8             	lea    -0x18(%ebp),%esi
 142:	01 f0                	add    %esi,%eax
 144:	2d fc 0d 00 00       	sub    $0xdfc,%eax
 149:	8b 30                	mov    (%eax),%esi
 14b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 14e:	89 c2                	mov    %eax,%edx
 150:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 157:	89 c2                	mov    %eax,%edx
 159:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 160:	29 d0                	sub    %edx,%eax
 162:	8d 4d e8             	lea    -0x18(%ebp),%ecx
 165:	01 c8                	add    %ecx,%eax
 167:	2d 00 0e 00 00       	sub    $0xe00,%eax
 16c:	8b 18                	mov    (%eax),%ebx
 16e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 171:	89 c2                	mov    %eax,%edx
 173:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 17a:	89 c2                	mov    %eax,%edx
 17c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 183:	29 d0                	sub    %edx,%eax
 185:	8d 4d e8             	lea    -0x18(%ebp),%ecx
 188:	01 c8                	add    %ecx,%eax
 18a:	2d 04 0e 00 00       	sub    $0xe04,%eax
 18f:	8b 08                	mov    (%eax),%ecx
 191:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 194:	89 c2                	mov    %eax,%edx
 196:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 19d:	89 c2                	mov    %eax,%edx
 19f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 1a6:	29 d0                	sub    %edx,%eax
 1a8:	8d 55 e8             	lea    -0x18(%ebp),%edx
 1ab:	01 d0                	add    %edx,%eax
 1ad:	2d 08 0e 00 00       	sub    $0xe08,%eax
 1b2:	8b 00                	mov    (%eax),%eax
 1b4:	83 ec 08             	sub    $0x8,%esp
 1b7:	56                   	push   %esi
 1b8:	53                   	push   %ebx
 1b9:	51                   	push   %ecx
 1ba:	50                   	push   %eax
 1bb:	68 d3 0b 00 00       	push   $0xbd3
 1c0:	6a 01                	push   $0x1
 1c2:	e8 ee 05 00 00       	call   7b5 <printf>
 1c7:	83 c4 20             	add    $0x20,%esp
        print_ticks_as_seconds(table[i].elapsed);
 1ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1cd:	89 c2                	mov    %eax,%edx
 1cf:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 1d6:	89 c2                	mov    %eax,%edx
 1d8:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 1df:	29 d0                	sub    %edx,%eax
 1e1:	8d 5d e8             	lea    -0x18(%ebp),%ebx
 1e4:	01 d8                	add    %ebx,%eax
 1e6:	2d f8 0d 00 00       	sub    $0xdf8,%eax
 1eb:	8b 00                	mov    (%eax),%eax
 1ed:	83 ec 0c             	sub    $0xc,%esp
 1f0:	50                   	push   %eax
 1f1:	e8 0a fe ff ff       	call   0 <print_ticks_as_seconds>
 1f6:	83 c4 10             	add    $0x10,%esp
        printf(1, "\t");
 1f9:	83 ec 08             	sub    $0x8,%esp
 1fc:	68 e0 0b 00 00       	push   $0xbe0
 201:	6a 01                	push   $0x1
 203:	e8 ad 05 00 00       	call   7b5 <printf>
 208:	83 c4 10             	add    $0x10,%esp
        print_ticks_as_seconds(table[i].cpu_ticks_total);
 20b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 20e:	89 c2                	mov    %eax,%edx
 210:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 217:	89 c2                	mov    %eax,%edx
 219:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 220:	29 d0                	sub    %edx,%eax
 222:	8d 75 e8             	lea    -0x18(%ebp),%esi
 225:	01 f0                	add    %esi,%eax
 227:	2d f4 0d 00 00       	sub    $0xdf4,%eax
 22c:	8b 00                	mov    (%eax),%eax
 22e:	83 ec 0c             	sub    $0xc,%esp
 231:	50                   	push   %eax
 232:	e8 c9 fd ff ff       	call   0 <print_ticks_as_seconds>
 237:	83 c4 10             	add    $0x10,%esp
        printf(1, "\t%s\t%d\t%s\n", table[i].state, table[i].sz, table[i].name);
 23a:	8d 8d e0 f1 ff ff    	lea    -0xe20(%ebp),%ecx
 240:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 243:	89 c2                	mov    %eax,%edx
 245:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 24c:	89 c2                	mov    %eax,%edx
 24e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 255:	29 d0                	sub    %edx,%eax
 257:	83 c0 20             	add    $0x20,%eax
 25a:	01 c8                	add    %ecx,%eax
 25c:	8d 58 08             	lea    0x8(%eax),%ebx
 25f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 262:	89 c2                	mov    %eax,%edx
 264:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 26b:	89 c2                	mov    %eax,%edx
 26d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 274:	29 d0                	sub    %edx,%eax
 276:	8d 75 e8             	lea    -0x18(%ebp),%esi
 279:	01 f0                	add    %esi,%eax
 27b:	2d e4 0d 00 00       	sub    $0xde4,%eax
 280:	8b 08                	mov    (%eax),%ecx
 282:	8d b5 e0 f1 ff ff    	lea    -0xe20(%ebp),%esi
 288:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 28b:	89 c2                	mov    %eax,%edx
 28d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 294:	89 c2                	mov    %eax,%edx
 296:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 29d:	29 d0                	sub    %edx,%eax
 29f:	83 c0 10             	add    $0x10,%eax
 2a2:	01 f0                	add    %esi,%eax
 2a4:	83 c0 08             	add    $0x8,%eax
 2a7:	83 ec 0c             	sub    $0xc,%esp
 2aa:	53                   	push   %ebx
 2ab:	51                   	push   %ecx
 2ac:	50                   	push   %eax
 2ad:	68 e2 0b 00 00       	push   $0xbe2
 2b2:	6a 01                	push   $0x1
 2b4:	e8 fc 04 00 00       	call   7b5 <printf>
 2b9:	83 c4 20             	add    $0x20,%esp
        exit();
    }

    printf(1, PSHEADER);    

    for(i = 0; i < nprocesses; i++) {
 2bc:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 2c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2c3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
 2c6:	0f 8c 31 fe ff ff    	jl     fd <main+0x68>
 2cc:	eb 01                	jmp    2cf <main+0x23a>
        if(table[i].pid == 0)
            break;
 2ce:	90                   	nop
        printf(1, "\t");
        print_ticks_as_seconds(table[i].cpu_ticks_total);
        printf(1, "\t%s\t%d\t%s\n", table[i].state, table[i].sz, table[i].name);
    }   
  
    exit();
 2cf:	e8 2a 03 00 00       	call   5fe <exit>

000002d4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	57                   	push   %edi
 2d8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 2d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2dc:	8b 55 10             	mov    0x10(%ebp),%edx
 2df:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e2:	89 cb                	mov    %ecx,%ebx
 2e4:	89 df                	mov    %ebx,%edi
 2e6:	89 d1                	mov    %edx,%ecx
 2e8:	fc                   	cld    
 2e9:	f3 aa                	rep stos %al,%es:(%edi)
 2eb:	89 ca                	mov    %ecx,%edx
 2ed:	89 fb                	mov    %edi,%ebx
 2ef:	89 5d 08             	mov    %ebx,0x8(%ebp)
 2f2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 2f5:	90                   	nop
 2f6:	5b                   	pop    %ebx
 2f7:	5f                   	pop    %edi
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret    

000002fa <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2fa:	55                   	push   %ebp
 2fb:	89 e5                	mov    %esp,%ebp
 2fd:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 306:	90                   	nop
 307:	8b 45 08             	mov    0x8(%ebp),%eax
 30a:	8d 50 01             	lea    0x1(%eax),%edx
 30d:	89 55 08             	mov    %edx,0x8(%ebp)
 310:	8b 55 0c             	mov    0xc(%ebp),%edx
 313:	8d 4a 01             	lea    0x1(%edx),%ecx
 316:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 319:	0f b6 12             	movzbl (%edx),%edx
 31c:	88 10                	mov    %dl,(%eax)
 31e:	0f b6 00             	movzbl (%eax),%eax
 321:	84 c0                	test   %al,%al
 323:	75 e2                	jne    307 <strcpy+0xd>
    ;
  return os;
 325:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 328:	c9                   	leave  
 329:	c3                   	ret    

0000032a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 32a:	55                   	push   %ebp
 32b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 32d:	eb 08                	jmp    337 <strcmp+0xd>
    p++, q++;
 32f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 333:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	0f b6 00             	movzbl (%eax),%eax
 33d:	84 c0                	test   %al,%al
 33f:	74 10                	je     351 <strcmp+0x27>
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	0f b6 10             	movzbl (%eax),%edx
 347:	8b 45 0c             	mov    0xc(%ebp),%eax
 34a:	0f b6 00             	movzbl (%eax),%eax
 34d:	38 c2                	cmp    %al,%dl
 34f:	74 de                	je     32f <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 351:	8b 45 08             	mov    0x8(%ebp),%eax
 354:	0f b6 00             	movzbl (%eax),%eax
 357:	0f b6 d0             	movzbl %al,%edx
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	0f b6 00             	movzbl (%eax),%eax
 360:	0f b6 c0             	movzbl %al,%eax
 363:	29 c2                	sub    %eax,%edx
 365:	89 d0                	mov    %edx,%eax
}
 367:	5d                   	pop    %ebp
 368:	c3                   	ret    

00000369 <strlen>:

uint
strlen(char *s)
{
 369:	55                   	push   %ebp
 36a:	89 e5                	mov    %esp,%ebp
 36c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 36f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 376:	eb 04                	jmp    37c <strlen+0x13>
 378:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 37c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 37f:	8b 45 08             	mov    0x8(%ebp),%eax
 382:	01 d0                	add    %edx,%eax
 384:	0f b6 00             	movzbl (%eax),%eax
 387:	84 c0                	test   %al,%al
 389:	75 ed                	jne    378 <strlen+0xf>
    ;
  return n;
 38b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 38e:	c9                   	leave  
 38f:	c3                   	ret    

00000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 393:	8b 45 10             	mov    0x10(%ebp),%eax
 396:	50                   	push   %eax
 397:	ff 75 0c             	pushl  0xc(%ebp)
 39a:	ff 75 08             	pushl  0x8(%ebp)
 39d:	e8 32 ff ff ff       	call   2d4 <stosb>
 3a2:	83 c4 0c             	add    $0xc,%esp
  return dst;
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3a8:	c9                   	leave  
 3a9:	c3                   	ret    

000003aa <strchr>:

char*
strchr(const char *s, char c)
{
 3aa:	55                   	push   %ebp
 3ab:	89 e5                	mov    %esp,%ebp
 3ad:	83 ec 04             	sub    $0x4,%esp
 3b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b3:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 3b6:	eb 14                	jmp    3cc <strchr+0x22>
    if(*s == c)
 3b8:	8b 45 08             	mov    0x8(%ebp),%eax
 3bb:	0f b6 00             	movzbl (%eax),%eax
 3be:	3a 45 fc             	cmp    -0x4(%ebp),%al
 3c1:	75 05                	jne    3c8 <strchr+0x1e>
      return (char*)s;
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	eb 13                	jmp    3db <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3c8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3cc:	8b 45 08             	mov    0x8(%ebp),%eax
 3cf:	0f b6 00             	movzbl (%eax),%eax
 3d2:	84 c0                	test   %al,%al
 3d4:	75 e2                	jne    3b8 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 3d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3db:	c9                   	leave  
 3dc:	c3                   	ret    

000003dd <gets>:

char*
gets(char *buf, int max)
{
 3dd:	55                   	push   %ebp
 3de:	89 e5                	mov    %esp,%ebp
 3e0:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3ea:	eb 42                	jmp    42e <gets+0x51>
    cc = read(0, &c, 1);
 3ec:	83 ec 04             	sub    $0x4,%esp
 3ef:	6a 01                	push   $0x1
 3f1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 3f4:	50                   	push   %eax
 3f5:	6a 00                	push   $0x0
 3f7:	e8 1a 02 00 00       	call   616 <read>
 3fc:	83 c4 10             	add    $0x10,%esp
 3ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 402:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 406:	7e 33                	jle    43b <gets+0x5e>
      break;
    buf[i++] = c;
 408:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40b:	8d 50 01             	lea    0x1(%eax),%edx
 40e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 411:	89 c2                	mov    %eax,%edx
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	01 c2                	add    %eax,%edx
 418:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 41c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 41e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 422:	3c 0a                	cmp    $0xa,%al
 424:	74 16                	je     43c <gets+0x5f>
 426:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 42a:	3c 0d                	cmp    $0xd,%al
 42c:	74 0e                	je     43c <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 42e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 431:	83 c0 01             	add    $0x1,%eax
 434:	3b 45 0c             	cmp    0xc(%ebp),%eax
 437:	7c b3                	jl     3ec <gets+0xf>
 439:	eb 01                	jmp    43c <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 43b:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 43c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 43f:	8b 45 08             	mov    0x8(%ebp),%eax
 442:	01 d0                	add    %edx,%eax
 444:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 447:	8b 45 08             	mov    0x8(%ebp),%eax
}
 44a:	c9                   	leave  
 44b:	c3                   	ret    

0000044c <stat>:

int
stat(char *n, struct stat *st)
{
 44c:	55                   	push   %ebp
 44d:	89 e5                	mov    %esp,%ebp
 44f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 452:	83 ec 08             	sub    $0x8,%esp
 455:	6a 00                	push   $0x0
 457:	ff 75 08             	pushl  0x8(%ebp)
 45a:	e8 df 01 00 00       	call   63e <open>
 45f:	83 c4 10             	add    $0x10,%esp
 462:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 465:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 469:	79 07                	jns    472 <stat+0x26>
    return -1;
 46b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 470:	eb 25                	jmp    497 <stat+0x4b>
  r = fstat(fd, st);
 472:	83 ec 08             	sub    $0x8,%esp
 475:	ff 75 0c             	pushl  0xc(%ebp)
 478:	ff 75 f4             	pushl  -0xc(%ebp)
 47b:	e8 d6 01 00 00       	call   656 <fstat>
 480:	83 c4 10             	add    $0x10,%esp
 483:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 486:	83 ec 0c             	sub    $0xc,%esp
 489:	ff 75 f4             	pushl  -0xc(%ebp)
 48c:	e8 95 01 00 00       	call   626 <close>
 491:	83 c4 10             	add    $0x10,%esp
  return r;
 494:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 497:	c9                   	leave  
 498:	c3                   	ret    

00000499 <atoi>:

int
atoi(const char *s)
{
 499:	55                   	push   %ebp
 49a:	89 e5                	mov    %esp,%ebp
 49c:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 49f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 4a6:	eb 04                	jmp    4ac <atoi+0x13>
 4a8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 4ac:	8b 45 08             	mov    0x8(%ebp),%eax
 4af:	0f b6 00             	movzbl (%eax),%eax
 4b2:	3c 20                	cmp    $0x20,%al
 4b4:	74 f2                	je     4a8 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 4b6:	8b 45 08             	mov    0x8(%ebp),%eax
 4b9:	0f b6 00             	movzbl (%eax),%eax
 4bc:	3c 2d                	cmp    $0x2d,%al
 4be:	75 07                	jne    4c7 <atoi+0x2e>
 4c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4c5:	eb 05                	jmp    4cc <atoi+0x33>
 4c7:	b8 01 00 00 00       	mov    $0x1,%eax
 4cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 4cf:	8b 45 08             	mov    0x8(%ebp),%eax
 4d2:	0f b6 00             	movzbl (%eax),%eax
 4d5:	3c 2b                	cmp    $0x2b,%al
 4d7:	74 0a                	je     4e3 <atoi+0x4a>
 4d9:	8b 45 08             	mov    0x8(%ebp),%eax
 4dc:	0f b6 00             	movzbl (%eax),%eax
 4df:	3c 2d                	cmp    $0x2d,%al
 4e1:	75 2b                	jne    50e <atoi+0x75>
    s++;
 4e3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 4e7:	eb 25                	jmp    50e <atoi+0x75>
    n = n*10 + *s++ - '0';
 4e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4ec:	89 d0                	mov    %edx,%eax
 4ee:	c1 e0 02             	shl    $0x2,%eax
 4f1:	01 d0                	add    %edx,%eax
 4f3:	01 c0                	add    %eax,%eax
 4f5:	89 c1                	mov    %eax,%ecx
 4f7:	8b 45 08             	mov    0x8(%ebp),%eax
 4fa:	8d 50 01             	lea    0x1(%eax),%edx
 4fd:	89 55 08             	mov    %edx,0x8(%ebp)
 500:	0f b6 00             	movzbl (%eax),%eax
 503:	0f be c0             	movsbl %al,%eax
 506:	01 c8                	add    %ecx,%eax
 508:	83 e8 30             	sub    $0x30,%eax
 50b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 50e:	8b 45 08             	mov    0x8(%ebp),%eax
 511:	0f b6 00             	movzbl (%eax),%eax
 514:	3c 2f                	cmp    $0x2f,%al
 516:	7e 0a                	jle    522 <atoi+0x89>
 518:	8b 45 08             	mov    0x8(%ebp),%eax
 51b:	0f b6 00             	movzbl (%eax),%eax
 51e:	3c 39                	cmp    $0x39,%al
 520:	7e c7                	jle    4e9 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 522:	8b 45 f8             	mov    -0x8(%ebp),%eax
 525:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 529:	c9                   	leave  
 52a:	c3                   	ret    

0000052b <atoo>:

int
atoo(const char *s)
{
 52b:	55                   	push   %ebp
 52c:	89 e5                	mov    %esp,%ebp
 52e:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 531:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 538:	eb 04                	jmp    53e <atoo+0x13>
 53a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 53e:	8b 45 08             	mov    0x8(%ebp),%eax
 541:	0f b6 00             	movzbl (%eax),%eax
 544:	3c 20                	cmp    $0x20,%al
 546:	74 f2                	je     53a <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 548:	8b 45 08             	mov    0x8(%ebp),%eax
 54b:	0f b6 00             	movzbl (%eax),%eax
 54e:	3c 2d                	cmp    $0x2d,%al
 550:	75 07                	jne    559 <atoo+0x2e>
 552:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 557:	eb 05                	jmp    55e <atoo+0x33>
 559:	b8 01 00 00 00       	mov    $0x1,%eax
 55e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 561:	8b 45 08             	mov    0x8(%ebp),%eax
 564:	0f b6 00             	movzbl (%eax),%eax
 567:	3c 2b                	cmp    $0x2b,%al
 569:	74 0a                	je     575 <atoo+0x4a>
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	0f b6 00             	movzbl (%eax),%eax
 571:	3c 2d                	cmp    $0x2d,%al
 573:	75 27                	jne    59c <atoo+0x71>
    s++;
 575:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 579:	eb 21                	jmp    59c <atoo+0x71>
    n = n*8 + *s++ - '0';
 57b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 57e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 585:	8b 45 08             	mov    0x8(%ebp),%eax
 588:	8d 50 01             	lea    0x1(%eax),%edx
 58b:	89 55 08             	mov    %edx,0x8(%ebp)
 58e:	0f b6 00             	movzbl (%eax),%eax
 591:	0f be c0             	movsbl %al,%eax
 594:	01 c8                	add    %ecx,%eax
 596:	83 e8 30             	sub    $0x30,%eax
 599:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 59c:	8b 45 08             	mov    0x8(%ebp),%eax
 59f:	0f b6 00             	movzbl (%eax),%eax
 5a2:	3c 2f                	cmp    $0x2f,%al
 5a4:	7e 0a                	jle    5b0 <atoo+0x85>
 5a6:	8b 45 08             	mov    0x8(%ebp),%eax
 5a9:	0f b6 00             	movzbl (%eax),%eax
 5ac:	3c 37                	cmp    $0x37,%al
 5ae:	7e cb                	jle    57b <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 5b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5b3:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 5b7:	c9                   	leave  
 5b8:	c3                   	ret    

000005b9 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 5b9:	55                   	push   %ebp
 5ba:	89 e5                	mov    %esp,%ebp
 5bc:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 5bf:	8b 45 08             	mov    0x8(%ebp),%eax
 5c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 5c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 5cb:	eb 17                	jmp    5e4 <memmove+0x2b>
    *dst++ = *src++;
 5cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d0:	8d 50 01             	lea    0x1(%eax),%edx
 5d3:	89 55 fc             	mov    %edx,-0x4(%ebp)
 5d6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 5d9:	8d 4a 01             	lea    0x1(%edx),%ecx
 5dc:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 5df:	0f b6 12             	movzbl (%edx),%edx
 5e2:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5e4:	8b 45 10             	mov    0x10(%ebp),%eax
 5e7:	8d 50 ff             	lea    -0x1(%eax),%edx
 5ea:	89 55 10             	mov    %edx,0x10(%ebp)
 5ed:	85 c0                	test   %eax,%eax
 5ef:	7f dc                	jg     5cd <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5f4:	c9                   	leave  
 5f5:	c3                   	ret    

000005f6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5f6:	b8 01 00 00 00       	mov    $0x1,%eax
 5fb:	cd 40                	int    $0x40
 5fd:	c3                   	ret    

000005fe <exit>:
SYSCALL(exit)
 5fe:	b8 02 00 00 00       	mov    $0x2,%eax
 603:	cd 40                	int    $0x40
 605:	c3                   	ret    

00000606 <wait>:
SYSCALL(wait)
 606:	b8 03 00 00 00       	mov    $0x3,%eax
 60b:	cd 40                	int    $0x40
 60d:	c3                   	ret    

0000060e <pipe>:
SYSCALL(pipe)
 60e:	b8 04 00 00 00       	mov    $0x4,%eax
 613:	cd 40                	int    $0x40
 615:	c3                   	ret    

00000616 <read>:
SYSCALL(read)
 616:	b8 05 00 00 00       	mov    $0x5,%eax
 61b:	cd 40                	int    $0x40
 61d:	c3                   	ret    

0000061e <write>:
SYSCALL(write)
 61e:	b8 10 00 00 00       	mov    $0x10,%eax
 623:	cd 40                	int    $0x40
 625:	c3                   	ret    

00000626 <close>:
SYSCALL(close)
 626:	b8 15 00 00 00       	mov    $0x15,%eax
 62b:	cd 40                	int    $0x40
 62d:	c3                   	ret    

0000062e <kill>:
SYSCALL(kill)
 62e:	b8 06 00 00 00       	mov    $0x6,%eax
 633:	cd 40                	int    $0x40
 635:	c3                   	ret    

00000636 <exec>:
SYSCALL(exec)
 636:	b8 07 00 00 00       	mov    $0x7,%eax
 63b:	cd 40                	int    $0x40
 63d:	c3                   	ret    

0000063e <open>:
SYSCALL(open)
 63e:	b8 0f 00 00 00       	mov    $0xf,%eax
 643:	cd 40                	int    $0x40
 645:	c3                   	ret    

00000646 <mknod>:
SYSCALL(mknod)
 646:	b8 11 00 00 00       	mov    $0x11,%eax
 64b:	cd 40                	int    $0x40
 64d:	c3                   	ret    

0000064e <unlink>:
SYSCALL(unlink)
 64e:	b8 12 00 00 00       	mov    $0x12,%eax
 653:	cd 40                	int    $0x40
 655:	c3                   	ret    

00000656 <fstat>:
SYSCALL(fstat)
 656:	b8 08 00 00 00       	mov    $0x8,%eax
 65b:	cd 40                	int    $0x40
 65d:	c3                   	ret    

0000065e <link>:
SYSCALL(link)
 65e:	b8 13 00 00 00       	mov    $0x13,%eax
 663:	cd 40                	int    $0x40
 665:	c3                   	ret    

00000666 <mkdir>:
SYSCALL(mkdir)
 666:	b8 14 00 00 00       	mov    $0x14,%eax
 66b:	cd 40                	int    $0x40
 66d:	c3                   	ret    

0000066e <chdir>:
SYSCALL(chdir)
 66e:	b8 09 00 00 00       	mov    $0x9,%eax
 673:	cd 40                	int    $0x40
 675:	c3                   	ret    

00000676 <dup>:
SYSCALL(dup)
 676:	b8 0a 00 00 00       	mov    $0xa,%eax
 67b:	cd 40                	int    $0x40
 67d:	c3                   	ret    

0000067e <getpid>:
SYSCALL(getpid)
 67e:	b8 0b 00 00 00       	mov    $0xb,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <sbrk>:
SYSCALL(sbrk)
 686:	b8 0c 00 00 00       	mov    $0xc,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <sleep>:
SYSCALL(sleep)
 68e:	b8 0d 00 00 00       	mov    $0xd,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <uptime>:
SYSCALL(uptime)
 696:	b8 0e 00 00 00       	mov    $0xe,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <halt>:
SYSCALL(halt)
 69e:	b8 16 00 00 00       	mov    $0x16,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <date>:
SYSCALL(date)
 6a6:	b8 17 00 00 00       	mov    $0x17,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <getuid>:
SYSCALL(getuid)
 6ae:	b8 18 00 00 00       	mov    $0x18,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <getgid>:
SYSCALL(getgid)
 6b6:	b8 19 00 00 00       	mov    $0x19,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <getppid>:
SYSCALL(getppid)
 6be:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <setuid>:
SYSCALL(setuid)
 6c6:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <setgid>:
SYSCALL(setgid)
 6ce:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <getprocs>:
SYSCALL(getprocs)
 6d6:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 6de:	55                   	push   %ebp
 6df:	89 e5                	mov    %esp,%ebp
 6e1:	83 ec 18             	sub    $0x18,%esp
 6e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e7:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 6ea:	83 ec 04             	sub    $0x4,%esp
 6ed:	6a 01                	push   $0x1
 6ef:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6f2:	50                   	push   %eax
 6f3:	ff 75 08             	pushl  0x8(%ebp)
 6f6:	e8 23 ff ff ff       	call   61e <write>
 6fb:	83 c4 10             	add    $0x10,%esp
}
 6fe:	90                   	nop
 6ff:	c9                   	leave  
 700:	c3                   	ret    

00000701 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 701:	55                   	push   %ebp
 702:	89 e5                	mov    %esp,%ebp
 704:	53                   	push   %ebx
 705:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 708:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 70f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 713:	74 17                	je     72c <printint+0x2b>
 715:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 719:	79 11                	jns    72c <printint+0x2b>
    neg = 1;
 71b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 722:	8b 45 0c             	mov    0xc(%ebp),%eax
 725:	f7 d8                	neg    %eax
 727:	89 45 ec             	mov    %eax,-0x14(%ebp)
 72a:	eb 06                	jmp    732 <printint+0x31>
  } else {
    x = xx;
 72c:	8b 45 0c             	mov    0xc(%ebp),%eax
 72f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 732:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 739:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 73c:	8d 41 01             	lea    0x1(%ecx),%eax
 73f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 742:	8b 5d 10             	mov    0x10(%ebp),%ebx
 745:	8b 45 ec             	mov    -0x14(%ebp),%eax
 748:	ba 00 00 00 00       	mov    $0x0,%edx
 74d:	f7 f3                	div    %ebx
 74f:	89 d0                	mov    %edx,%eax
 751:	0f b6 80 84 0e 00 00 	movzbl 0xe84(%eax),%eax
 758:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 75c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 75f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 762:	ba 00 00 00 00       	mov    $0x0,%edx
 767:	f7 f3                	div    %ebx
 769:	89 45 ec             	mov    %eax,-0x14(%ebp)
 76c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 770:	75 c7                	jne    739 <printint+0x38>
  if(neg)
 772:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 776:	74 2d                	je     7a5 <printint+0xa4>
    buf[i++] = '-';
 778:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77b:	8d 50 01             	lea    0x1(%eax),%edx
 77e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 781:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 786:	eb 1d                	jmp    7a5 <printint+0xa4>
    putc(fd, buf[i]);
 788:	8d 55 dc             	lea    -0x24(%ebp),%edx
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	01 d0                	add    %edx,%eax
 790:	0f b6 00             	movzbl (%eax),%eax
 793:	0f be c0             	movsbl %al,%eax
 796:	83 ec 08             	sub    $0x8,%esp
 799:	50                   	push   %eax
 79a:	ff 75 08             	pushl  0x8(%ebp)
 79d:	e8 3c ff ff ff       	call   6de <putc>
 7a2:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7a5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 7a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7ad:	79 d9                	jns    788 <printint+0x87>
    putc(fd, buf[i]);
}
 7af:	90                   	nop
 7b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7b3:	c9                   	leave  
 7b4:	c3                   	ret    

000007b5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7b5:	55                   	push   %ebp
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 7bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 7c2:	8d 45 0c             	lea    0xc(%ebp),%eax
 7c5:	83 c0 04             	add    $0x4,%eax
 7c8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 7cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7d2:	e9 59 01 00 00       	jmp    930 <printf+0x17b>
    c = fmt[i] & 0xff;
 7d7:	8b 55 0c             	mov    0xc(%ebp),%edx
 7da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7dd:	01 d0                	add    %edx,%eax
 7df:	0f b6 00             	movzbl (%eax),%eax
 7e2:	0f be c0             	movsbl %al,%eax
 7e5:	25 ff 00 00 00       	and    $0xff,%eax
 7ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7f1:	75 2c                	jne    81f <printf+0x6a>
      if(c == '%'){
 7f3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7f7:	75 0c                	jne    805 <printf+0x50>
        state = '%';
 7f9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 800:	e9 27 01 00 00       	jmp    92c <printf+0x177>
      } else {
        putc(fd, c);
 805:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 808:	0f be c0             	movsbl %al,%eax
 80b:	83 ec 08             	sub    $0x8,%esp
 80e:	50                   	push   %eax
 80f:	ff 75 08             	pushl  0x8(%ebp)
 812:	e8 c7 fe ff ff       	call   6de <putc>
 817:	83 c4 10             	add    $0x10,%esp
 81a:	e9 0d 01 00 00       	jmp    92c <printf+0x177>
      }
    } else if(state == '%'){
 81f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 823:	0f 85 03 01 00 00    	jne    92c <printf+0x177>
      if(c == 'd'){
 829:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 82d:	75 1e                	jne    84d <printf+0x98>
        printint(fd, *ap, 10, 1);
 82f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 832:	8b 00                	mov    (%eax),%eax
 834:	6a 01                	push   $0x1
 836:	6a 0a                	push   $0xa
 838:	50                   	push   %eax
 839:	ff 75 08             	pushl  0x8(%ebp)
 83c:	e8 c0 fe ff ff       	call   701 <printint>
 841:	83 c4 10             	add    $0x10,%esp
        ap++;
 844:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 848:	e9 d8 00 00 00       	jmp    925 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 84d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 851:	74 06                	je     859 <printf+0xa4>
 853:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 857:	75 1e                	jne    877 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 859:	8b 45 e8             	mov    -0x18(%ebp),%eax
 85c:	8b 00                	mov    (%eax),%eax
 85e:	6a 00                	push   $0x0
 860:	6a 10                	push   $0x10
 862:	50                   	push   %eax
 863:	ff 75 08             	pushl  0x8(%ebp)
 866:	e8 96 fe ff ff       	call   701 <printint>
 86b:	83 c4 10             	add    $0x10,%esp
        ap++;
 86e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 872:	e9 ae 00 00 00       	jmp    925 <printf+0x170>
      } else if(c == 's'){
 877:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 87b:	75 43                	jne    8c0 <printf+0x10b>
        s = (char*)*ap;
 87d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 880:	8b 00                	mov    (%eax),%eax
 882:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 885:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 889:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 88d:	75 25                	jne    8b4 <printf+0xff>
          s = "(null)";
 88f:	c7 45 f4 ed 0b 00 00 	movl   $0xbed,-0xc(%ebp)
        while(*s != 0){
 896:	eb 1c                	jmp    8b4 <printf+0xff>
          putc(fd, *s);
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	0f b6 00             	movzbl (%eax),%eax
 89e:	0f be c0             	movsbl %al,%eax
 8a1:	83 ec 08             	sub    $0x8,%esp
 8a4:	50                   	push   %eax
 8a5:	ff 75 08             	pushl  0x8(%ebp)
 8a8:	e8 31 fe ff ff       	call   6de <putc>
 8ad:	83 c4 10             	add    $0x10,%esp
          s++;
 8b0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b7:	0f b6 00             	movzbl (%eax),%eax
 8ba:	84 c0                	test   %al,%al
 8bc:	75 da                	jne    898 <printf+0xe3>
 8be:	eb 65                	jmp    925 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8c0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 8c4:	75 1d                	jne    8e3 <printf+0x12e>
        putc(fd, *ap);
 8c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8c9:	8b 00                	mov    (%eax),%eax
 8cb:	0f be c0             	movsbl %al,%eax
 8ce:	83 ec 08             	sub    $0x8,%esp
 8d1:	50                   	push   %eax
 8d2:	ff 75 08             	pushl  0x8(%ebp)
 8d5:	e8 04 fe ff ff       	call   6de <putc>
 8da:	83 c4 10             	add    $0x10,%esp
        ap++;
 8dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8e1:	eb 42                	jmp    925 <printf+0x170>
      } else if(c == '%'){
 8e3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8e7:	75 17                	jne    900 <printf+0x14b>
        putc(fd, c);
 8e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8ec:	0f be c0             	movsbl %al,%eax
 8ef:	83 ec 08             	sub    $0x8,%esp
 8f2:	50                   	push   %eax
 8f3:	ff 75 08             	pushl  0x8(%ebp)
 8f6:	e8 e3 fd ff ff       	call   6de <putc>
 8fb:	83 c4 10             	add    $0x10,%esp
 8fe:	eb 25                	jmp    925 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 900:	83 ec 08             	sub    $0x8,%esp
 903:	6a 25                	push   $0x25
 905:	ff 75 08             	pushl  0x8(%ebp)
 908:	e8 d1 fd ff ff       	call   6de <putc>
 90d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 910:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 913:	0f be c0             	movsbl %al,%eax
 916:	83 ec 08             	sub    $0x8,%esp
 919:	50                   	push   %eax
 91a:	ff 75 08             	pushl  0x8(%ebp)
 91d:	e8 bc fd ff ff       	call   6de <putc>
 922:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 925:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 92c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 930:	8b 55 0c             	mov    0xc(%ebp),%edx
 933:	8b 45 f0             	mov    -0x10(%ebp),%eax
 936:	01 d0                	add    %edx,%eax
 938:	0f b6 00             	movzbl (%eax),%eax
 93b:	84 c0                	test   %al,%al
 93d:	0f 85 94 fe ff ff    	jne    7d7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 943:	90                   	nop
 944:	c9                   	leave  
 945:	c3                   	ret    

00000946 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 946:	55                   	push   %ebp
 947:	89 e5                	mov    %esp,%ebp
 949:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 94c:	8b 45 08             	mov    0x8(%ebp),%eax
 94f:	83 e8 08             	sub    $0x8,%eax
 952:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 955:	a1 a0 0e 00 00       	mov    0xea0,%eax
 95a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 95d:	eb 24                	jmp    983 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 962:	8b 00                	mov    (%eax),%eax
 964:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 967:	77 12                	ja     97b <free+0x35>
 969:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 96f:	77 24                	ja     995 <free+0x4f>
 971:	8b 45 fc             	mov    -0x4(%ebp),%eax
 974:	8b 00                	mov    (%eax),%eax
 976:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 979:	77 1a                	ja     995 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97e:	8b 00                	mov    (%eax),%eax
 980:	89 45 fc             	mov    %eax,-0x4(%ebp)
 983:	8b 45 f8             	mov    -0x8(%ebp),%eax
 986:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 989:	76 d4                	jbe    95f <free+0x19>
 98b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98e:	8b 00                	mov    (%eax),%eax
 990:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 993:	76 ca                	jbe    95f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 995:	8b 45 f8             	mov    -0x8(%ebp),%eax
 998:	8b 40 04             	mov    0x4(%eax),%eax
 99b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a5:	01 c2                	add    %eax,%edx
 9a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9aa:	8b 00                	mov    (%eax),%eax
 9ac:	39 c2                	cmp    %eax,%edx
 9ae:	75 24                	jne    9d4 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 9b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9b3:	8b 50 04             	mov    0x4(%eax),%edx
 9b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b9:	8b 00                	mov    (%eax),%eax
 9bb:	8b 40 04             	mov    0x4(%eax),%eax
 9be:	01 c2                	add    %eax,%edx
 9c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9c3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c9:	8b 00                	mov    (%eax),%eax
 9cb:	8b 10                	mov    (%eax),%edx
 9cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d0:	89 10                	mov    %edx,(%eax)
 9d2:	eb 0a                	jmp    9de <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d7:	8b 10                	mov    (%eax),%edx
 9d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9dc:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e1:	8b 40 04             	mov    0x4(%eax),%eax
 9e4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ee:	01 d0                	add    %edx,%eax
 9f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9f3:	75 20                	jne    a15 <free+0xcf>
    p->s.size += bp->s.size;
 9f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f8:	8b 50 04             	mov    0x4(%eax),%edx
 9fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9fe:	8b 40 04             	mov    0x4(%eax),%eax
 a01:	01 c2                	add    %eax,%edx
 a03:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a06:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a09:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a0c:	8b 10                	mov    (%eax),%edx
 a0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a11:	89 10                	mov    %edx,(%eax)
 a13:	eb 08                	jmp    a1d <free+0xd7>
  } else
    p->s.ptr = bp;
 a15:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a18:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a1b:	89 10                	mov    %edx,(%eax)
  freep = p;
 a1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a20:	a3 a0 0e 00 00       	mov    %eax,0xea0
}
 a25:	90                   	nop
 a26:	c9                   	leave  
 a27:	c3                   	ret    

00000a28 <morecore>:

static Header*
morecore(uint nu)
{
 a28:	55                   	push   %ebp
 a29:	89 e5                	mov    %esp,%ebp
 a2b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a2e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a35:	77 07                	ja     a3e <morecore+0x16>
    nu = 4096;
 a37:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a3e:	8b 45 08             	mov    0x8(%ebp),%eax
 a41:	c1 e0 03             	shl    $0x3,%eax
 a44:	83 ec 0c             	sub    $0xc,%esp
 a47:	50                   	push   %eax
 a48:	e8 39 fc ff ff       	call   686 <sbrk>
 a4d:	83 c4 10             	add    $0x10,%esp
 a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a53:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a57:	75 07                	jne    a60 <morecore+0x38>
    return 0;
 a59:	b8 00 00 00 00       	mov    $0x0,%eax
 a5e:	eb 26                	jmp    a86 <morecore+0x5e>
  hp = (Header*)p;
 a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a66:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a69:	8b 55 08             	mov    0x8(%ebp),%edx
 a6c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a72:	83 c0 08             	add    $0x8,%eax
 a75:	83 ec 0c             	sub    $0xc,%esp
 a78:	50                   	push   %eax
 a79:	e8 c8 fe ff ff       	call   946 <free>
 a7e:	83 c4 10             	add    $0x10,%esp
  return freep;
 a81:	a1 a0 0e 00 00       	mov    0xea0,%eax
}
 a86:	c9                   	leave  
 a87:	c3                   	ret    

00000a88 <malloc>:

void*
malloc(uint nbytes)
{
 a88:	55                   	push   %ebp
 a89:	89 e5                	mov    %esp,%ebp
 a8b:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a8e:	8b 45 08             	mov    0x8(%ebp),%eax
 a91:	83 c0 07             	add    $0x7,%eax
 a94:	c1 e8 03             	shr    $0x3,%eax
 a97:	83 c0 01             	add    $0x1,%eax
 a9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a9d:	a1 a0 0e 00 00       	mov    0xea0,%eax
 aa2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 aa5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 aa9:	75 23                	jne    ace <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 aab:	c7 45 f0 98 0e 00 00 	movl   $0xe98,-0x10(%ebp)
 ab2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ab5:	a3 a0 0e 00 00       	mov    %eax,0xea0
 aba:	a1 a0 0e 00 00       	mov    0xea0,%eax
 abf:	a3 98 0e 00 00       	mov    %eax,0xe98
    base.s.size = 0;
 ac4:	c7 05 9c 0e 00 00 00 	movl   $0x0,0xe9c
 acb:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ad1:	8b 00                	mov    (%eax),%eax
 ad3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 ad6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad9:	8b 40 04             	mov    0x4(%eax),%eax
 adc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 adf:	72 4d                	jb     b2e <malloc+0xa6>
      if(p->s.size == nunits)
 ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae4:	8b 40 04             	mov    0x4(%eax),%eax
 ae7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aea:	75 0c                	jne    af8 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aef:	8b 10                	mov    (%eax),%edx
 af1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af4:	89 10                	mov    %edx,(%eax)
 af6:	eb 26                	jmp    b1e <malloc+0x96>
      else {
        p->s.size -= nunits;
 af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afb:	8b 40 04             	mov    0x4(%eax),%eax
 afe:	2b 45 ec             	sub    -0x14(%ebp),%eax
 b01:	89 c2                	mov    %eax,%edx
 b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b06:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b0c:	8b 40 04             	mov    0x4(%eax),%eax
 b0f:	c1 e0 03             	shl    $0x3,%eax
 b12:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b18:	8b 55 ec             	mov    -0x14(%ebp),%edx
 b1b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 b1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b21:	a3 a0 0e 00 00       	mov    %eax,0xea0
      return (void*)(p + 1);
 b26:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b29:	83 c0 08             	add    $0x8,%eax
 b2c:	eb 3b                	jmp    b69 <malloc+0xe1>
    }
    if(p == freep)
 b2e:	a1 a0 0e 00 00       	mov    0xea0,%eax
 b33:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b36:	75 1e                	jne    b56 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 b38:	83 ec 0c             	sub    $0xc,%esp
 b3b:	ff 75 ec             	pushl  -0x14(%ebp)
 b3e:	e8 e5 fe ff ff       	call   a28 <morecore>
 b43:	83 c4 10             	add    $0x10,%esp
 b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b4d:	75 07                	jne    b56 <malloc+0xce>
        return 0;
 b4f:	b8 00 00 00 00       	mov    $0x0,%eax
 b54:	eb 13                	jmp    b69 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b59:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b5f:	8b 00                	mov    (%eax),%eax
 b61:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b64:	e9 6d ff ff ff       	jmp    ad6 <malloc+0x4e>
}
 b69:	c9                   	leave  
 b6a:	c3                   	ret    
