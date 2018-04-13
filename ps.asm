
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
  3c:	68 08 0b 00 00       	push   $0xb08
  41:	6a 01                	push   $0x1
  43:	e8 09 07 00 00       	call   751 <printf>
  48:	83 c4 10             	add    $0x10,%esp
  if(fractional_part < 10) 
  4b:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  4f:	77 14                	ja     65 <print_ticks_as_seconds+0x65>
    printf(1, "00");
  51:	83 ec 08             	sub    $0x8,%esp
  54:	68 0c 0b 00 00       	push   $0xb0c
  59:	6a 01                	push   $0x1
  5b:	e8 f1 06 00 00       	call   751 <printf>
  60:	83 c4 10             	add    $0x10,%esp
  63:	eb 18                	jmp    7d <print_ticks_as_seconds+0x7d>
  else if(fractional_part < 100)
  65:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  69:	77 12                	ja     7d <print_ticks_as_seconds+0x7d>
    printf(1, "0");
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	68 0f 0b 00 00       	push   $0xb0f
  73:	6a 01                	push   $0x1
  75:	e8 d7 06 00 00       	call   751 <printf>
  7a:	83 c4 10             	add    $0x10,%esp
  printf(1, "%d", fractional_part);
  7d:	83 ec 04             	sub    $0x4,%esp
  80:	ff 75 f0             	pushl  -0x10(%ebp)
  83:	68 11 0b 00 00       	push   $0xb11
  88:	6a 01                	push   $0x1
  8a:	e8 c2 06 00 00       	call   751 <printf>
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
  a5:	83 ec 1c             	sub    $0x1c,%esp
    int i;
    int nprocesses;
    struct uproc *table;

    table = malloc(sizeof(struct uproc) * MAX);
  a8:	83 ec 0c             	sub    $0xc,%esp
  ab:	68 00 0e 00 00       	push   $0xe00
  b0:	e8 6f 09 00 00       	call   a24 <malloc>
  b5:	83 c4 10             	add    $0x10,%esp
  b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nprocesses = getprocs(MAX, &table[0]);
  bb:	83 ec 08             	sub    $0x8,%esp
  be:	ff 75 e0             	pushl  -0x20(%ebp)
  c1:	6a 40                	push   $0x40
  c3:	e8 aa 05 00 00       	call   672 <getprocs>
  c8:	83 c4 10             	add    $0x10,%esp
  cb:	89 45 dc             	mov    %eax,-0x24(%ebp)

    if(nprocesses < 0) {
  ce:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  d2:	79 17                	jns    eb <main+0x56>
        printf(2, "ERROR: unable to construct Process Table\n");
  d4:	83 ec 08             	sub    $0x8,%esp
  d7:	68 14 0b 00 00       	push   $0xb14
  dc:	6a 02                	push   $0x2
  de:	e8 6e 06 00 00       	call   751 <printf>
  e3:	83 c4 10             	add    $0x10,%esp
        exit();
  e6:	e8 af 04 00 00       	call   59a <exit>
    }

    printf(1, PSHEADER);    
  eb:	83 ec 08             	sub    $0x8,%esp
  ee:	68 40 0b 00 00       	push   $0xb40
  f3:	6a 01                	push   $0x1
  f5:	e8 57 06 00 00       	call   751 <printf>
  fa:	83 c4 10             	add    $0x10,%esp

    for(i = 0; i < nprocesses; i++) {
  fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 104:	e9 45 01 00 00       	jmp    24e <main+0x1b9>
        if(table[i].pid == 0)
 109:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 10c:	c1 e0 03             	shl    $0x3,%eax
 10f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 116:	29 c2                	sub    %eax,%edx
 118:	8b 45 e0             	mov    -0x20(%ebp),%eax
 11b:	01 d0                	add    %edx,%eax
 11d:	8b 00                	mov    (%eax),%eax
 11f:	85 c0                	test   %eax,%eax
 121:	0f 84 35 01 00 00    	je     25c <main+0x1c7>
            break;
        printf(1, "%d\t%d\t%d\t%d\t", table[i].pid, table[i].uid, table[i].gid, table[i].ppid);
 127:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 12a:	c1 e0 03             	shl    $0x3,%eax
 12d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 134:	29 c2                	sub    %eax,%edx
 136:	8b 45 e0             	mov    -0x20(%ebp),%eax
 139:	01 d0                	add    %edx,%eax
 13b:	8b 58 0c             	mov    0xc(%eax),%ebx
 13e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 141:	c1 e0 03             	shl    $0x3,%eax
 144:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 14b:	29 c2                	sub    %eax,%edx
 14d:	8b 45 e0             	mov    -0x20(%ebp),%eax
 150:	01 d0                	add    %edx,%eax
 152:	8b 48 08             	mov    0x8(%eax),%ecx
 155:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 158:	c1 e0 03             	shl    $0x3,%eax
 15b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 162:	29 c2                	sub    %eax,%edx
 164:	8b 45 e0             	mov    -0x20(%ebp),%eax
 167:	01 d0                	add    %edx,%eax
 169:	8b 50 04             	mov    0x4(%eax),%edx
 16c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 16f:	c1 e0 03             	shl    $0x3,%eax
 172:	8d 34 c5 00 00 00 00 	lea    0x0(,%eax,8),%esi
 179:	29 c6                	sub    %eax,%esi
 17b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 17e:	01 f0                	add    %esi,%eax
 180:	8b 00                	mov    (%eax),%eax
 182:	83 ec 08             	sub    $0x8,%esp
 185:	53                   	push   %ebx
 186:	51                   	push   %ecx
 187:	52                   	push   %edx
 188:	50                   	push   %eax
 189:	68 6f 0b 00 00       	push   $0xb6f
 18e:	6a 01                	push   $0x1
 190:	e8 bc 05 00 00       	call   751 <printf>
 195:	83 c4 20             	add    $0x20,%esp
        print_ticks_as_seconds(table[i].elapsed);
 198:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 19b:	c1 e0 03             	shl    $0x3,%eax
 19e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 1a5:	29 c2                	sub    %eax,%edx
 1a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1aa:	01 d0                	add    %edx,%eax
 1ac:	8b 40 10             	mov    0x10(%eax),%eax
 1af:	83 ec 0c             	sub    $0xc,%esp
 1b2:	50                   	push   %eax
 1b3:	e8 48 fe ff ff       	call   0 <print_ticks_as_seconds>
 1b8:	83 c4 10             	add    $0x10,%esp
        printf(1, "\t");
 1bb:	83 ec 08             	sub    $0x8,%esp
 1be:	68 7c 0b 00 00       	push   $0xb7c
 1c3:	6a 01                	push   $0x1
 1c5:	e8 87 05 00 00       	call   751 <printf>
 1ca:	83 c4 10             	add    $0x10,%esp
        print_ticks_as_seconds(table[i].cpu_ticks_total);
 1cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1d0:	c1 e0 03             	shl    $0x3,%eax
 1d3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 1da:	29 c2                	sub    %eax,%edx
 1dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1df:	01 d0                	add    %edx,%eax
 1e1:	8b 40 14             	mov    0x14(%eax),%eax
 1e4:	83 ec 0c             	sub    $0xc,%esp
 1e7:	50                   	push   %eax
 1e8:	e8 13 fe ff ff       	call   0 <print_ticks_as_seconds>
 1ed:	83 c4 10             	add    $0x10,%esp
        printf(1, "\t%s\t%d\t%s\n", table[i].state, table[i].sz, table[i].name);
 1f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1f3:	c1 e0 03             	shl    $0x3,%eax
 1f6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 1fd:	29 c2                	sub    %eax,%edx
 1ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
 202:	01 d0                	add    %edx,%eax
 204:	8d 48 28             	lea    0x28(%eax),%ecx
 207:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 20a:	c1 e0 03             	shl    $0x3,%eax
 20d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 214:	29 c2                	sub    %eax,%edx
 216:	8b 45 e0             	mov    -0x20(%ebp),%eax
 219:	01 d0                	add    %edx,%eax
 21b:	8b 50 24             	mov    0x24(%eax),%edx
 21e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 221:	c1 e0 03             	shl    $0x3,%eax
 224:	8d 1c c5 00 00 00 00 	lea    0x0(,%eax,8),%ebx
 22b:	29 c3                	sub    %eax,%ebx
 22d:	8b 45 e0             	mov    -0x20(%ebp),%eax
 230:	01 d8                	add    %ebx,%eax
 232:	83 c0 18             	add    $0x18,%eax
 235:	83 ec 0c             	sub    $0xc,%esp
 238:	51                   	push   %ecx
 239:	52                   	push   %edx
 23a:	50                   	push   %eax
 23b:	68 7e 0b 00 00       	push   $0xb7e
 240:	6a 01                	push   $0x1
 242:	e8 0a 05 00 00       	call   751 <printf>
 247:	83 c4 20             	add    $0x20,%esp
        exit();
    }

    printf(1, PSHEADER);    

    for(i = 0; i < nprocesses; i++) {
 24a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 24e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 251:	3b 45 dc             	cmp    -0x24(%ebp),%eax
 254:	0f 8c af fe ff ff    	jl     109 <main+0x74>
 25a:	eb 01                	jmp    25d <main+0x1c8>
        if(table[i].pid == 0)
            break;
 25c:	90                   	nop
        printf(1, "\t");
        print_ticks_as_seconds(table[i].cpu_ticks_total);
        printf(1, "\t%s\t%d\t%s\n", table[i].state, table[i].sz, table[i].name);
    }   
  
    free(table);
 25d:	83 ec 0c             	sub    $0xc,%esp
 260:	ff 75 e0             	pushl  -0x20(%ebp)
 263:	e8 7a 06 00 00       	call   8e2 <free>
 268:	83 c4 10             	add    $0x10,%esp
    exit();
 26b:	e8 2a 03 00 00       	call   59a <exit>

00000270 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 275:	8b 4d 08             	mov    0x8(%ebp),%ecx
 278:	8b 55 10             	mov    0x10(%ebp),%edx
 27b:	8b 45 0c             	mov    0xc(%ebp),%eax
 27e:	89 cb                	mov    %ecx,%ebx
 280:	89 df                	mov    %ebx,%edi
 282:	89 d1                	mov    %edx,%ecx
 284:	fc                   	cld    
 285:	f3 aa                	rep stos %al,%es:(%edi)
 287:	89 ca                	mov    %ecx,%edx
 289:	89 fb                	mov    %edi,%ebx
 28b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 28e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 291:	90                   	nop
 292:	5b                   	pop    %ebx
 293:	5f                   	pop    %edi
 294:	5d                   	pop    %ebp
 295:	c3                   	ret    

00000296 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 296:	55                   	push   %ebp
 297:	89 e5                	mov    %esp,%ebp
 299:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
 29f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 2a2:	90                   	nop
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	8d 50 01             	lea    0x1(%eax),%edx
 2a9:	89 55 08             	mov    %edx,0x8(%ebp)
 2ac:	8b 55 0c             	mov    0xc(%ebp),%edx
 2af:	8d 4a 01             	lea    0x1(%edx),%ecx
 2b2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 2b5:	0f b6 12             	movzbl (%edx),%edx
 2b8:	88 10                	mov    %dl,(%eax)
 2ba:	0f b6 00             	movzbl (%eax),%eax
 2bd:	84 c0                	test   %al,%al
 2bf:	75 e2                	jne    2a3 <strcpy+0xd>
    ;
  return os;
 2c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 2c9:	eb 08                	jmp    2d3 <strcmp+0xd>
    p++, q++;
 2cb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2cf:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d3:	8b 45 08             	mov    0x8(%ebp),%eax
 2d6:	0f b6 00             	movzbl (%eax),%eax
 2d9:	84 c0                	test   %al,%al
 2db:	74 10                	je     2ed <strcmp+0x27>
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	0f b6 10             	movzbl (%eax),%edx
 2e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e6:	0f b6 00             	movzbl (%eax),%eax
 2e9:	38 c2                	cmp    %al,%dl
 2eb:	74 de                	je     2cb <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2ed:	8b 45 08             	mov    0x8(%ebp),%eax
 2f0:	0f b6 00             	movzbl (%eax),%eax
 2f3:	0f b6 d0             	movzbl %al,%edx
 2f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f9:	0f b6 00             	movzbl (%eax),%eax
 2fc:	0f b6 c0             	movzbl %al,%eax
 2ff:	29 c2                	sub    %eax,%edx
 301:	89 d0                	mov    %edx,%eax
}
 303:	5d                   	pop    %ebp
 304:	c3                   	ret    

00000305 <strlen>:

uint
strlen(char *s)
{
 305:	55                   	push   %ebp
 306:	89 e5                	mov    %esp,%ebp
 308:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 30b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 312:	eb 04                	jmp    318 <strlen+0x13>
 314:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 318:	8b 55 fc             	mov    -0x4(%ebp),%edx
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	01 d0                	add    %edx,%eax
 320:	0f b6 00             	movzbl (%eax),%eax
 323:	84 c0                	test   %al,%al
 325:	75 ed                	jne    314 <strlen+0xf>
    ;
  return n;
 327:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 32a:	c9                   	leave  
 32b:	c3                   	ret    

0000032c <memset>:

void*
memset(void *dst, int c, uint n)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 32f:	8b 45 10             	mov    0x10(%ebp),%eax
 332:	50                   	push   %eax
 333:	ff 75 0c             	pushl  0xc(%ebp)
 336:	ff 75 08             	pushl  0x8(%ebp)
 339:	e8 32 ff ff ff       	call   270 <stosb>
 33e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 341:	8b 45 08             	mov    0x8(%ebp),%eax
}
 344:	c9                   	leave  
 345:	c3                   	ret    

00000346 <strchr>:

char*
strchr(const char *s, char c)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	83 ec 04             	sub    $0x4,%esp
 34c:	8b 45 0c             	mov    0xc(%ebp),%eax
 34f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 352:	eb 14                	jmp    368 <strchr+0x22>
    if(*s == c)
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	0f b6 00             	movzbl (%eax),%eax
 35a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 35d:	75 05                	jne    364 <strchr+0x1e>
      return (char*)s;
 35f:	8b 45 08             	mov    0x8(%ebp),%eax
 362:	eb 13                	jmp    377 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 364:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	0f b6 00             	movzbl (%eax),%eax
 36e:	84 c0                	test   %al,%al
 370:	75 e2                	jne    354 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 372:	b8 00 00 00 00       	mov    $0x0,%eax
}
 377:	c9                   	leave  
 378:	c3                   	ret    

00000379 <gets>:

char*
gets(char *buf, int max)
{
 379:	55                   	push   %ebp
 37a:	89 e5                	mov    %esp,%ebp
 37c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 37f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 386:	eb 42                	jmp    3ca <gets+0x51>
    cc = read(0, &c, 1);
 388:	83 ec 04             	sub    $0x4,%esp
 38b:	6a 01                	push   $0x1
 38d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 390:	50                   	push   %eax
 391:	6a 00                	push   $0x0
 393:	e8 1a 02 00 00       	call   5b2 <read>
 398:	83 c4 10             	add    $0x10,%esp
 39b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 39e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3a2:	7e 33                	jle    3d7 <gets+0x5e>
      break;
    buf[i++] = c;
 3a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a7:	8d 50 01             	lea    0x1(%eax),%edx
 3aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ad:	89 c2                	mov    %eax,%edx
 3af:	8b 45 08             	mov    0x8(%ebp),%eax
 3b2:	01 c2                	add    %eax,%edx
 3b4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3b8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 3ba:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3be:	3c 0a                	cmp    $0xa,%al
 3c0:	74 16                	je     3d8 <gets+0x5f>
 3c2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3c6:	3c 0d                	cmp    $0xd,%al
 3c8:	74 0e                	je     3d8 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3cd:	83 c0 01             	add    $0x1,%eax
 3d0:	3b 45 0c             	cmp    0xc(%ebp),%eax
 3d3:	7c b3                	jl     388 <gets+0xf>
 3d5:	eb 01                	jmp    3d8 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 3d7:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3db:	8b 45 08             	mov    0x8(%ebp),%eax
 3de:	01 d0                	add    %edx,%eax
 3e0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3e6:	c9                   	leave  
 3e7:	c3                   	ret    

000003e8 <stat>:

int
stat(char *n, struct stat *st)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ee:	83 ec 08             	sub    $0x8,%esp
 3f1:	6a 00                	push   $0x0
 3f3:	ff 75 08             	pushl  0x8(%ebp)
 3f6:	e8 df 01 00 00       	call   5da <open>
 3fb:	83 c4 10             	add    $0x10,%esp
 3fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 401:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 405:	79 07                	jns    40e <stat+0x26>
    return -1;
 407:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 40c:	eb 25                	jmp    433 <stat+0x4b>
  r = fstat(fd, st);
 40e:	83 ec 08             	sub    $0x8,%esp
 411:	ff 75 0c             	pushl  0xc(%ebp)
 414:	ff 75 f4             	pushl  -0xc(%ebp)
 417:	e8 d6 01 00 00       	call   5f2 <fstat>
 41c:	83 c4 10             	add    $0x10,%esp
 41f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 422:	83 ec 0c             	sub    $0xc,%esp
 425:	ff 75 f4             	pushl  -0xc(%ebp)
 428:	e8 95 01 00 00       	call   5c2 <close>
 42d:	83 c4 10             	add    $0x10,%esp
  return r;
 430:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 433:	c9                   	leave  
 434:	c3                   	ret    

00000435 <atoi>:

int
atoi(const char *s)
{
 435:	55                   	push   %ebp
 436:	89 e5                	mov    %esp,%ebp
 438:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 43b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 442:	eb 04                	jmp    448 <atoi+0x13>
 444:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 448:	8b 45 08             	mov    0x8(%ebp),%eax
 44b:	0f b6 00             	movzbl (%eax),%eax
 44e:	3c 20                	cmp    $0x20,%al
 450:	74 f2                	je     444 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 452:	8b 45 08             	mov    0x8(%ebp),%eax
 455:	0f b6 00             	movzbl (%eax),%eax
 458:	3c 2d                	cmp    $0x2d,%al
 45a:	75 07                	jne    463 <atoi+0x2e>
 45c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 461:	eb 05                	jmp    468 <atoi+0x33>
 463:	b8 01 00 00 00       	mov    $0x1,%eax
 468:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 46b:	8b 45 08             	mov    0x8(%ebp),%eax
 46e:	0f b6 00             	movzbl (%eax),%eax
 471:	3c 2b                	cmp    $0x2b,%al
 473:	74 0a                	je     47f <atoi+0x4a>
 475:	8b 45 08             	mov    0x8(%ebp),%eax
 478:	0f b6 00             	movzbl (%eax),%eax
 47b:	3c 2d                	cmp    $0x2d,%al
 47d:	75 2b                	jne    4aa <atoi+0x75>
    s++;
 47f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 483:	eb 25                	jmp    4aa <atoi+0x75>
    n = n*10 + *s++ - '0';
 485:	8b 55 fc             	mov    -0x4(%ebp),%edx
 488:	89 d0                	mov    %edx,%eax
 48a:	c1 e0 02             	shl    $0x2,%eax
 48d:	01 d0                	add    %edx,%eax
 48f:	01 c0                	add    %eax,%eax
 491:	89 c1                	mov    %eax,%ecx
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	8d 50 01             	lea    0x1(%eax),%edx
 499:	89 55 08             	mov    %edx,0x8(%ebp)
 49c:	0f b6 00             	movzbl (%eax),%eax
 49f:	0f be c0             	movsbl %al,%eax
 4a2:	01 c8                	add    %ecx,%eax
 4a4:	83 e8 30             	sub    $0x30,%eax
 4a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 4aa:	8b 45 08             	mov    0x8(%ebp),%eax
 4ad:	0f b6 00             	movzbl (%eax),%eax
 4b0:	3c 2f                	cmp    $0x2f,%al
 4b2:	7e 0a                	jle    4be <atoi+0x89>
 4b4:	8b 45 08             	mov    0x8(%ebp),%eax
 4b7:	0f b6 00             	movzbl (%eax),%eax
 4ba:	3c 39                	cmp    $0x39,%al
 4bc:	7e c7                	jle    485 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 4be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 4c1:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 4c5:	c9                   	leave  
 4c6:	c3                   	ret    

000004c7 <atoo>:

int
atoo(const char *s)
{
 4c7:	55                   	push   %ebp
 4c8:	89 e5                	mov    %esp,%ebp
 4ca:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 4cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 4d4:	eb 04                	jmp    4da <atoo+0x13>
 4d6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 4da:	8b 45 08             	mov    0x8(%ebp),%eax
 4dd:	0f b6 00             	movzbl (%eax),%eax
 4e0:	3c 20                	cmp    $0x20,%al
 4e2:	74 f2                	je     4d6 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	0f b6 00             	movzbl (%eax),%eax
 4ea:	3c 2d                	cmp    $0x2d,%al
 4ec:	75 07                	jne    4f5 <atoo+0x2e>
 4ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4f3:	eb 05                	jmp    4fa <atoo+0x33>
 4f5:	b8 01 00 00 00       	mov    $0x1,%eax
 4fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 4fd:	8b 45 08             	mov    0x8(%ebp),%eax
 500:	0f b6 00             	movzbl (%eax),%eax
 503:	3c 2b                	cmp    $0x2b,%al
 505:	74 0a                	je     511 <atoo+0x4a>
 507:	8b 45 08             	mov    0x8(%ebp),%eax
 50a:	0f b6 00             	movzbl (%eax),%eax
 50d:	3c 2d                	cmp    $0x2d,%al
 50f:	75 27                	jne    538 <atoo+0x71>
    s++;
 511:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 515:	eb 21                	jmp    538 <atoo+0x71>
    n = n*8 + *s++ - '0';
 517:	8b 45 fc             	mov    -0x4(%ebp),%eax
 51a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 521:	8b 45 08             	mov    0x8(%ebp),%eax
 524:	8d 50 01             	lea    0x1(%eax),%edx
 527:	89 55 08             	mov    %edx,0x8(%ebp)
 52a:	0f b6 00             	movzbl (%eax),%eax
 52d:	0f be c0             	movsbl %al,%eax
 530:	01 c8                	add    %ecx,%eax
 532:	83 e8 30             	sub    $0x30,%eax
 535:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 538:	8b 45 08             	mov    0x8(%ebp),%eax
 53b:	0f b6 00             	movzbl (%eax),%eax
 53e:	3c 2f                	cmp    $0x2f,%al
 540:	7e 0a                	jle    54c <atoo+0x85>
 542:	8b 45 08             	mov    0x8(%ebp),%eax
 545:	0f b6 00             	movzbl (%eax),%eax
 548:	3c 37                	cmp    $0x37,%al
 54a:	7e cb                	jle    517 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 54c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 54f:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 553:	c9                   	leave  
 554:	c3                   	ret    

00000555 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 555:	55                   	push   %ebp
 556:	89 e5                	mov    %esp,%ebp
 558:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 55b:	8b 45 08             	mov    0x8(%ebp),%eax
 55e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 561:	8b 45 0c             	mov    0xc(%ebp),%eax
 564:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 567:	eb 17                	jmp    580 <memmove+0x2b>
    *dst++ = *src++;
 569:	8b 45 fc             	mov    -0x4(%ebp),%eax
 56c:	8d 50 01             	lea    0x1(%eax),%edx
 56f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 572:	8b 55 f8             	mov    -0x8(%ebp),%edx
 575:	8d 4a 01             	lea    0x1(%edx),%ecx
 578:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 57b:	0f b6 12             	movzbl (%edx),%edx
 57e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 580:	8b 45 10             	mov    0x10(%ebp),%eax
 583:	8d 50 ff             	lea    -0x1(%eax),%edx
 586:	89 55 10             	mov    %edx,0x10(%ebp)
 589:	85 c0                	test   %eax,%eax
 58b:	7f dc                	jg     569 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 590:	c9                   	leave  
 591:	c3                   	ret    

00000592 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 592:	b8 01 00 00 00       	mov    $0x1,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <exit>:
SYSCALL(exit)
 59a:	b8 02 00 00 00       	mov    $0x2,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <wait>:
SYSCALL(wait)
 5a2:	b8 03 00 00 00       	mov    $0x3,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <pipe>:
SYSCALL(pipe)
 5aa:	b8 04 00 00 00       	mov    $0x4,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <read>:
SYSCALL(read)
 5b2:	b8 05 00 00 00       	mov    $0x5,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <write>:
SYSCALL(write)
 5ba:	b8 10 00 00 00       	mov    $0x10,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <close>:
SYSCALL(close)
 5c2:	b8 15 00 00 00       	mov    $0x15,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <kill>:
SYSCALL(kill)
 5ca:	b8 06 00 00 00       	mov    $0x6,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <exec>:
SYSCALL(exec)
 5d2:	b8 07 00 00 00       	mov    $0x7,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <open>:
SYSCALL(open)
 5da:	b8 0f 00 00 00       	mov    $0xf,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <mknod>:
SYSCALL(mknod)
 5e2:	b8 11 00 00 00       	mov    $0x11,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <unlink>:
SYSCALL(unlink)
 5ea:	b8 12 00 00 00       	mov    $0x12,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <fstat>:
SYSCALL(fstat)
 5f2:	b8 08 00 00 00       	mov    $0x8,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <link>:
SYSCALL(link)
 5fa:	b8 13 00 00 00       	mov    $0x13,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <mkdir>:
SYSCALL(mkdir)
 602:	b8 14 00 00 00       	mov    $0x14,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <chdir>:
SYSCALL(chdir)
 60a:	b8 09 00 00 00       	mov    $0x9,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <dup>:
SYSCALL(dup)
 612:	b8 0a 00 00 00       	mov    $0xa,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <getpid>:
SYSCALL(getpid)
 61a:	b8 0b 00 00 00       	mov    $0xb,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <sbrk>:
SYSCALL(sbrk)
 622:	b8 0c 00 00 00       	mov    $0xc,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <sleep>:
SYSCALL(sleep)
 62a:	b8 0d 00 00 00       	mov    $0xd,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <uptime>:
SYSCALL(uptime)
 632:	b8 0e 00 00 00       	mov    $0xe,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <halt>:
SYSCALL(halt)
 63a:	b8 16 00 00 00       	mov    $0x16,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <date>:
SYSCALL(date)
 642:	b8 17 00 00 00       	mov    $0x17,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <getuid>:
SYSCALL(getuid)
 64a:	b8 18 00 00 00       	mov    $0x18,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <getgid>:
SYSCALL(getgid)
 652:	b8 19 00 00 00       	mov    $0x19,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <getppid>:
SYSCALL(getppid)
 65a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <setuid>:
SYSCALL(setuid)
 662:	b8 1b 00 00 00       	mov    $0x1b,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <setgid>:
SYSCALL(setgid)
 66a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <getprocs>:
SYSCALL(getprocs)
 672:	b8 1d 00 00 00       	mov    $0x1d,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 67a:	55                   	push   %ebp
 67b:	89 e5                	mov    %esp,%ebp
 67d:	83 ec 18             	sub    $0x18,%esp
 680:	8b 45 0c             	mov    0xc(%ebp),%eax
 683:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 686:	83 ec 04             	sub    $0x4,%esp
 689:	6a 01                	push   $0x1
 68b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 68e:	50                   	push   %eax
 68f:	ff 75 08             	pushl  0x8(%ebp)
 692:	e8 23 ff ff ff       	call   5ba <write>
 697:	83 c4 10             	add    $0x10,%esp
}
 69a:	90                   	nop
 69b:	c9                   	leave  
 69c:	c3                   	ret    

0000069d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 69d:	55                   	push   %ebp
 69e:	89 e5                	mov    %esp,%ebp
 6a0:	53                   	push   %ebx
 6a1:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6ab:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6af:	74 17                	je     6c8 <printint+0x2b>
 6b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6b5:	79 11                	jns    6c8 <printint+0x2b>
    neg = 1;
 6b7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6be:	8b 45 0c             	mov    0xc(%ebp),%eax
 6c1:	f7 d8                	neg    %eax
 6c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6c6:	eb 06                	jmp    6ce <printint+0x31>
  } else {
    x = xx;
 6c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 6cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6d5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 6d8:	8d 41 01             	lea    0x1(%ecx),%eax
 6db:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6de:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6e4:	ba 00 00 00 00       	mov    $0x0,%edx
 6e9:	f7 f3                	div    %ebx
 6eb:	89 d0                	mov    %edx,%eax
 6ed:	0f b6 80 20 0e 00 00 	movzbl 0xe20(%eax),%eax
 6f4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 6f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6fe:	ba 00 00 00 00       	mov    $0x0,%edx
 703:	f7 f3                	div    %ebx
 705:	89 45 ec             	mov    %eax,-0x14(%ebp)
 708:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 70c:	75 c7                	jne    6d5 <printint+0x38>
  if(neg)
 70e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 712:	74 2d                	je     741 <printint+0xa4>
    buf[i++] = '-';
 714:	8b 45 f4             	mov    -0xc(%ebp),%eax
 717:	8d 50 01             	lea    0x1(%eax),%edx
 71a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 71d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 722:	eb 1d                	jmp    741 <printint+0xa4>
    putc(fd, buf[i]);
 724:	8d 55 dc             	lea    -0x24(%ebp),%edx
 727:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72a:	01 d0                	add    %edx,%eax
 72c:	0f b6 00             	movzbl (%eax),%eax
 72f:	0f be c0             	movsbl %al,%eax
 732:	83 ec 08             	sub    $0x8,%esp
 735:	50                   	push   %eax
 736:	ff 75 08             	pushl  0x8(%ebp)
 739:	e8 3c ff ff ff       	call   67a <putc>
 73e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 741:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 745:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 749:	79 d9                	jns    724 <printint+0x87>
    putc(fd, buf[i]);
}
 74b:	90                   	nop
 74c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 74f:	c9                   	leave  
 750:	c3                   	ret    

00000751 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 751:	55                   	push   %ebp
 752:	89 e5                	mov    %esp,%ebp
 754:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 757:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 75e:	8d 45 0c             	lea    0xc(%ebp),%eax
 761:	83 c0 04             	add    $0x4,%eax
 764:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 767:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 76e:	e9 59 01 00 00       	jmp    8cc <printf+0x17b>
    c = fmt[i] & 0xff;
 773:	8b 55 0c             	mov    0xc(%ebp),%edx
 776:	8b 45 f0             	mov    -0x10(%ebp),%eax
 779:	01 d0                	add    %edx,%eax
 77b:	0f b6 00             	movzbl (%eax),%eax
 77e:	0f be c0             	movsbl %al,%eax
 781:	25 ff 00 00 00       	and    $0xff,%eax
 786:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 789:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 78d:	75 2c                	jne    7bb <printf+0x6a>
      if(c == '%'){
 78f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 793:	75 0c                	jne    7a1 <printf+0x50>
        state = '%';
 795:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 79c:	e9 27 01 00 00       	jmp    8c8 <printf+0x177>
      } else {
        putc(fd, c);
 7a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7a4:	0f be c0             	movsbl %al,%eax
 7a7:	83 ec 08             	sub    $0x8,%esp
 7aa:	50                   	push   %eax
 7ab:	ff 75 08             	pushl  0x8(%ebp)
 7ae:	e8 c7 fe ff ff       	call   67a <putc>
 7b3:	83 c4 10             	add    $0x10,%esp
 7b6:	e9 0d 01 00 00       	jmp    8c8 <printf+0x177>
      }
    } else if(state == '%'){
 7bb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7bf:	0f 85 03 01 00 00    	jne    8c8 <printf+0x177>
      if(c == 'd'){
 7c5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7c9:	75 1e                	jne    7e9 <printf+0x98>
        printint(fd, *ap, 10, 1);
 7cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ce:	8b 00                	mov    (%eax),%eax
 7d0:	6a 01                	push   $0x1
 7d2:	6a 0a                	push   $0xa
 7d4:	50                   	push   %eax
 7d5:	ff 75 08             	pushl  0x8(%ebp)
 7d8:	e8 c0 fe ff ff       	call   69d <printint>
 7dd:	83 c4 10             	add    $0x10,%esp
        ap++;
 7e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7e4:	e9 d8 00 00 00       	jmp    8c1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 7e9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7ed:	74 06                	je     7f5 <printf+0xa4>
 7ef:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7f3:	75 1e                	jne    813 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 7f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	6a 00                	push   $0x0
 7fc:	6a 10                	push   $0x10
 7fe:	50                   	push   %eax
 7ff:	ff 75 08             	pushl  0x8(%ebp)
 802:	e8 96 fe ff ff       	call   69d <printint>
 807:	83 c4 10             	add    $0x10,%esp
        ap++;
 80a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 80e:	e9 ae 00 00 00       	jmp    8c1 <printf+0x170>
      } else if(c == 's'){
 813:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 817:	75 43                	jne    85c <printf+0x10b>
        s = (char*)*ap;
 819:	8b 45 e8             	mov    -0x18(%ebp),%eax
 81c:	8b 00                	mov    (%eax),%eax
 81e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 821:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 825:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 829:	75 25                	jne    850 <printf+0xff>
          s = "(null)";
 82b:	c7 45 f4 89 0b 00 00 	movl   $0xb89,-0xc(%ebp)
        while(*s != 0){
 832:	eb 1c                	jmp    850 <printf+0xff>
          putc(fd, *s);
 834:	8b 45 f4             	mov    -0xc(%ebp),%eax
 837:	0f b6 00             	movzbl (%eax),%eax
 83a:	0f be c0             	movsbl %al,%eax
 83d:	83 ec 08             	sub    $0x8,%esp
 840:	50                   	push   %eax
 841:	ff 75 08             	pushl  0x8(%ebp)
 844:	e8 31 fe ff ff       	call   67a <putc>
 849:	83 c4 10             	add    $0x10,%esp
          s++;
 84c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	0f b6 00             	movzbl (%eax),%eax
 856:	84 c0                	test   %al,%al
 858:	75 da                	jne    834 <printf+0xe3>
 85a:	eb 65                	jmp    8c1 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 85c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 860:	75 1d                	jne    87f <printf+0x12e>
        putc(fd, *ap);
 862:	8b 45 e8             	mov    -0x18(%ebp),%eax
 865:	8b 00                	mov    (%eax),%eax
 867:	0f be c0             	movsbl %al,%eax
 86a:	83 ec 08             	sub    $0x8,%esp
 86d:	50                   	push   %eax
 86e:	ff 75 08             	pushl  0x8(%ebp)
 871:	e8 04 fe ff ff       	call   67a <putc>
 876:	83 c4 10             	add    $0x10,%esp
        ap++;
 879:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 87d:	eb 42                	jmp    8c1 <printf+0x170>
      } else if(c == '%'){
 87f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 883:	75 17                	jne    89c <printf+0x14b>
        putc(fd, c);
 885:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 888:	0f be c0             	movsbl %al,%eax
 88b:	83 ec 08             	sub    $0x8,%esp
 88e:	50                   	push   %eax
 88f:	ff 75 08             	pushl  0x8(%ebp)
 892:	e8 e3 fd ff ff       	call   67a <putc>
 897:	83 c4 10             	add    $0x10,%esp
 89a:	eb 25                	jmp    8c1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 89c:	83 ec 08             	sub    $0x8,%esp
 89f:	6a 25                	push   $0x25
 8a1:	ff 75 08             	pushl  0x8(%ebp)
 8a4:	e8 d1 fd ff ff       	call   67a <putc>
 8a9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 8ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8af:	0f be c0             	movsbl %al,%eax
 8b2:	83 ec 08             	sub    $0x8,%esp
 8b5:	50                   	push   %eax
 8b6:	ff 75 08             	pushl  0x8(%ebp)
 8b9:	e8 bc fd ff ff       	call   67a <putc>
 8be:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8c8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8cc:	8b 55 0c             	mov    0xc(%ebp),%edx
 8cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d2:	01 d0                	add    %edx,%eax
 8d4:	0f b6 00             	movzbl (%eax),%eax
 8d7:	84 c0                	test   %al,%al
 8d9:	0f 85 94 fe ff ff    	jne    773 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8df:	90                   	nop
 8e0:	c9                   	leave  
 8e1:	c3                   	ret    

000008e2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e2:	55                   	push   %ebp
 8e3:	89 e5                	mov    %esp,%ebp
 8e5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8e8:	8b 45 08             	mov    0x8(%ebp),%eax
 8eb:	83 e8 08             	sub    $0x8,%eax
 8ee:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f1:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 8f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8f9:	eb 24                	jmp    91f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fe:	8b 00                	mov    (%eax),%eax
 900:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 903:	77 12                	ja     917 <free+0x35>
 905:	8b 45 f8             	mov    -0x8(%ebp),%eax
 908:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 90b:	77 24                	ja     931 <free+0x4f>
 90d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 910:	8b 00                	mov    (%eax),%eax
 912:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 915:	77 1a                	ja     931 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 917:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91a:	8b 00                	mov    (%eax),%eax
 91c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 91f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 922:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 925:	76 d4                	jbe    8fb <free+0x19>
 927:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92a:	8b 00                	mov    (%eax),%eax
 92c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 92f:	76 ca                	jbe    8fb <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 931:	8b 45 f8             	mov    -0x8(%ebp),%eax
 934:	8b 40 04             	mov    0x4(%eax),%eax
 937:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 93e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 941:	01 c2                	add    %eax,%edx
 943:	8b 45 fc             	mov    -0x4(%ebp),%eax
 946:	8b 00                	mov    (%eax),%eax
 948:	39 c2                	cmp    %eax,%edx
 94a:	75 24                	jne    970 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 94c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 94f:	8b 50 04             	mov    0x4(%eax),%edx
 952:	8b 45 fc             	mov    -0x4(%ebp),%eax
 955:	8b 00                	mov    (%eax),%eax
 957:	8b 40 04             	mov    0x4(%eax),%eax
 95a:	01 c2                	add    %eax,%edx
 95c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 962:	8b 45 fc             	mov    -0x4(%ebp),%eax
 965:	8b 00                	mov    (%eax),%eax
 967:	8b 10                	mov    (%eax),%edx
 969:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96c:	89 10                	mov    %edx,(%eax)
 96e:	eb 0a                	jmp    97a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 970:	8b 45 fc             	mov    -0x4(%ebp),%eax
 973:	8b 10                	mov    (%eax),%edx
 975:	8b 45 f8             	mov    -0x8(%ebp),%eax
 978:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 97a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97d:	8b 40 04             	mov    0x4(%eax),%eax
 980:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 987:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98a:	01 d0                	add    %edx,%eax
 98c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 98f:	75 20                	jne    9b1 <free+0xcf>
    p->s.size += bp->s.size;
 991:	8b 45 fc             	mov    -0x4(%ebp),%eax
 994:	8b 50 04             	mov    0x4(%eax),%edx
 997:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99a:	8b 40 04             	mov    0x4(%eax),%eax
 99d:	01 c2                	add    %eax,%edx
 99f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a8:	8b 10                	mov    (%eax),%edx
 9aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ad:	89 10                	mov    %edx,(%eax)
 9af:	eb 08                	jmp    9b9 <free+0xd7>
  } else
    p->s.ptr = bp;
 9b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9b7:	89 10                	mov    %edx,(%eax)
  freep = p;
 9b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bc:	a3 3c 0e 00 00       	mov    %eax,0xe3c
}
 9c1:	90                   	nop
 9c2:	c9                   	leave  
 9c3:	c3                   	ret    

000009c4 <morecore>:

static Header*
morecore(uint nu)
{
 9c4:	55                   	push   %ebp
 9c5:	89 e5                	mov    %esp,%ebp
 9c7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9ca:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9d1:	77 07                	ja     9da <morecore+0x16>
    nu = 4096;
 9d3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9da:	8b 45 08             	mov    0x8(%ebp),%eax
 9dd:	c1 e0 03             	shl    $0x3,%eax
 9e0:	83 ec 0c             	sub    $0xc,%esp
 9e3:	50                   	push   %eax
 9e4:	e8 39 fc ff ff       	call   622 <sbrk>
 9e9:	83 c4 10             	add    $0x10,%esp
 9ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9ef:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9f3:	75 07                	jne    9fc <morecore+0x38>
    return 0;
 9f5:	b8 00 00 00 00       	mov    $0x0,%eax
 9fa:	eb 26                	jmp    a22 <morecore+0x5e>
  hp = (Header*)p;
 9fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a02:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a05:	8b 55 08             	mov    0x8(%ebp),%edx
 a08:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a0e:	83 c0 08             	add    $0x8,%eax
 a11:	83 ec 0c             	sub    $0xc,%esp
 a14:	50                   	push   %eax
 a15:	e8 c8 fe ff ff       	call   8e2 <free>
 a1a:	83 c4 10             	add    $0x10,%esp
  return freep;
 a1d:	a1 3c 0e 00 00       	mov    0xe3c,%eax
}
 a22:	c9                   	leave  
 a23:	c3                   	ret    

00000a24 <malloc>:

void*
malloc(uint nbytes)
{
 a24:	55                   	push   %ebp
 a25:	89 e5                	mov    %esp,%ebp
 a27:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a2a:	8b 45 08             	mov    0x8(%ebp),%eax
 a2d:	83 c0 07             	add    $0x7,%eax
 a30:	c1 e8 03             	shr    $0x3,%eax
 a33:	83 c0 01             	add    $0x1,%eax
 a36:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a39:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 a3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a41:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a45:	75 23                	jne    a6a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a47:	c7 45 f0 34 0e 00 00 	movl   $0xe34,-0x10(%ebp)
 a4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a51:	a3 3c 0e 00 00       	mov    %eax,0xe3c
 a56:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 a5b:	a3 34 0e 00 00       	mov    %eax,0xe34
    base.s.size = 0;
 a60:	c7 05 38 0e 00 00 00 	movl   $0x0,0xe38
 a67:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a6d:	8b 00                	mov    (%eax),%eax
 a6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a72:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a75:	8b 40 04             	mov    0x4(%eax),%eax
 a78:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a7b:	72 4d                	jb     aca <malloc+0xa6>
      if(p->s.size == nunits)
 a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a80:	8b 40 04             	mov    0x4(%eax),%eax
 a83:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a86:	75 0c                	jne    a94 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8b:	8b 10                	mov    (%eax),%edx
 a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a90:	89 10                	mov    %edx,(%eax)
 a92:	eb 26                	jmp    aba <malloc+0x96>
      else {
        p->s.size -= nunits;
 a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a97:	8b 40 04             	mov    0x4(%eax),%eax
 a9a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a9d:	89 c2                	mov    %eax,%edx
 a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa8:	8b 40 04             	mov    0x4(%eax),%eax
 aab:	c1 e0 03             	shl    $0x3,%eax
 aae:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 ab7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 abd:	a3 3c 0e 00 00       	mov    %eax,0xe3c
      return (void*)(p + 1);
 ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac5:	83 c0 08             	add    $0x8,%eax
 ac8:	eb 3b                	jmp    b05 <malloc+0xe1>
    }
    if(p == freep)
 aca:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 acf:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 ad2:	75 1e                	jne    af2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 ad4:	83 ec 0c             	sub    $0xc,%esp
 ad7:	ff 75 ec             	pushl  -0x14(%ebp)
 ada:	e8 e5 fe ff ff       	call   9c4 <morecore>
 adf:	83 c4 10             	add    $0x10,%esp
 ae2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 ae5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ae9:	75 07                	jne    af2 <malloc+0xce>
        return 0;
 aeb:	b8 00 00 00 00       	mov    $0x0,%eax
 af0:	eb 13                	jmp    b05 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afb:	8b 00                	mov    (%eax),%eax
 afd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b00:	e9 6d ff ff ff       	jmp    a72 <malloc+0x4e>
}
 b05:	c9                   	leave  
 b06:	c3                   	ret    
