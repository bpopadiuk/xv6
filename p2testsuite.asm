
_p2testsuite:     file format elf32-i386


Disassembly of section .text:

00000000 <testppid>:
#include "uproc.h"
#endif

#ifdef UIDGIDPPID_TEST
static void
testppid(void){
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int ret, pid, ppid;

  printf(1, "\n----------\nRunning PPID Test\n----------\n");
       6:	83 ec 08             	sub    $0x8,%esp
       9:	68 44 16 00 00       	push   $0x1644
       e:	6a 01                	push   $0x1
      10:	e8 79 12 00 00       	call   128e <printf>
      15:	83 c4 10             	add    $0x10,%esp
  pid = getpid();
      18:	e8 3a 11 00 00       	call   1157 <getpid>
      1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ret = fork();
      20:	e8 aa 10 00 00       	call   10cf <fork>
      25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(ret == 0){
      28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      2c:	75 3e                	jne    6c <testppid+0x6c>
    ppid = getppid();
      2e:	e8 64 11 00 00       	call   1197 <getppid>
      33:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(ppid != pid)
      36:	8b 45 ec             	mov    -0x14(%ebp),%eax
      39:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      3c:	74 17                	je     55 <testppid+0x55>
      printf(2, "FAILED: Parent PID is %d, Child's PPID is %d\n", pid, ppid);
      3e:	ff 75 ec             	pushl  -0x14(%ebp)
      41:	ff 75 f4             	pushl  -0xc(%ebp)
      44:	68 70 16 00 00       	push   $0x1670
      49:	6a 02                	push   $0x2
      4b:	e8 3e 12 00 00       	call   128e <printf>
      50:	83 c4 10             	add    $0x10,%esp
      53:	eb 12                	jmp    67 <testppid+0x67>
    else
      printf(1, "** Test passed! **\n");
      55:	83 ec 08             	sub    $0x8,%esp
      58:	68 9e 16 00 00       	push   $0x169e
      5d:	6a 01                	push   $0x1
      5f:	e8 2a 12 00 00       	call   128e <printf>
      64:	83 c4 10             	add    $0x10,%esp
    exit();
      67:	e8 6b 10 00 00       	call   10d7 <exit>
  }
  else
    wait();
      6c:	e8 6e 10 00 00       	call   10df <wait>
}
      71:	90                   	nop
      72:	c9                   	leave  
      73:	c3                   	ret    

00000074 <testgid>:

static int
testgid(uint new_val, uint expected_get_val, int expected_set_ret){
      74:	55                   	push   %ebp
      75:	89 e5                	mov    %esp,%ebp
      77:	83 ec 18             	sub    $0x18,%esp
  int ret;
  uint post_gid, pre_gid;
  int success = 0;
      7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  pre_gid = getgid();
      81:	e8 09 11 00 00       	call   118f <getgid>
      86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = setgid(new_val);
      89:	83 ec 0c             	sub    $0xc,%esp
      8c:	ff 75 08             	pushl  0x8(%ebp)
      8f:	e8 13 11 00 00       	call   11a7 <setgid>
      94:	83 c4 10             	add    $0x10,%esp
      97:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
      9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      9e:	79 06                	jns    a6 <testgid+0x32>
      a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
      a4:	79 0c                	jns    b2 <testgid+0x3e>
      a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      aa:	78 28                	js     d4 <testgid+0x60>
      ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
      b0:	79 22                	jns    d4 <testgid+0x60>
    printf(2, "FAILED: setgid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
      b2:	83 ec 0c             	sub    $0xc,%esp
      b5:	ff 75 10             	pushl  0x10(%ebp)
      b8:	ff 75 ec             	pushl  -0x14(%ebp)
      bb:	ff 75 08             	pushl  0x8(%ebp)
      be:	68 b4 16 00 00       	push   $0x16b4
      c3:	6a 02                	push   $0x2
      c5:	e8 c4 11 00 00       	call   128e <printf>
      ca:	83 c4 20             	add    $0x20,%esp
    success = -1;
      cd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  post_gid = getgid();
      d4:	e8 b6 10 00 00       	call   118f <getgid>
      d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(post_gid != expected_get_val){
      dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
      df:	3b 45 0c             	cmp    0xc(%ebp),%eax
      e2:	74 25                	je     109 <testgid+0x95>
    printf(2, "FAILED: UID was %d. After setgid(%d), getgid() returned %d, expected %d\n", 
      e4:	83 ec 08             	sub    $0x8,%esp
      e7:	ff 75 0c             	pushl  0xc(%ebp)
      ea:	ff 75 e8             	pushl  -0x18(%ebp)
      ed:	ff 75 08             	pushl  0x8(%ebp)
      f0:	ff 75 f0             	pushl  -0x10(%ebp)
      f3:	68 e4 16 00 00       	push   $0x16e4
      f8:	6a 02                	push   $0x2
      fa:	e8 8f 11 00 00       	call   128e <printf>
      ff:	83 c4 20             	add    $0x20,%esp
          pre_gid, new_val, post_gid, expected_get_val);
    success = -1;
     102:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  return success;
     109:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     10c:	c9                   	leave  
     10d:	c3                   	ret    

0000010e <testuid>:

static int
testuid(uint new_val, uint expected_get_val, int expected_set_ret){
     10e:	55                   	push   %ebp
     10f:	89 e5                	mov    %esp,%ebp
     111:	83 ec 18             	sub    $0x18,%esp
  int ret;
  uint post_uid, pre_uid;
  int success = 0;
     114:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  pre_uid = getuid();
     11b:	e8 67 10 00 00       	call   1187 <getuid>
     120:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = setuid(new_val);
     123:	83 ec 0c             	sub    $0xc,%esp
     126:	ff 75 08             	pushl  0x8(%ebp)
     129:	e8 71 10 00 00       	call   119f <setuid>
     12e:	83 c4 10             	add    $0x10,%esp
     131:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
     134:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     138:	79 06                	jns    140 <testuid+0x32>
     13a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     13e:	79 0c                	jns    14c <testuid+0x3e>
     140:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     144:	78 28                	js     16e <testuid+0x60>
     146:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     14a:	79 22                	jns    16e <testuid+0x60>
    printf(2, "FAILED: setuid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
     14c:	83 ec 0c             	sub    $0xc,%esp
     14f:	ff 75 10             	pushl  0x10(%ebp)
     152:	ff 75 ec             	pushl  -0x14(%ebp)
     155:	ff 75 08             	pushl  0x8(%ebp)
     158:	68 30 17 00 00       	push   $0x1730
     15d:	6a 02                	push   $0x2
     15f:	e8 2a 11 00 00       	call   128e <printf>
     164:	83 c4 20             	add    $0x20,%esp
    success = -1;
     167:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  post_uid = getuid();
     16e:	e8 14 10 00 00       	call   1187 <getuid>
     173:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(post_uid != expected_get_val){
     176:	8b 45 e8             	mov    -0x18(%ebp),%eax
     179:	3b 45 0c             	cmp    0xc(%ebp),%eax
     17c:	74 25                	je     1a3 <testuid+0x95>
    printf(2, "FAILED: UID was %d. After setuid(%d), getuid() returned %d, expected %d\n", 
     17e:	83 ec 08             	sub    $0x8,%esp
     181:	ff 75 0c             	pushl  0xc(%ebp)
     184:	ff 75 e8             	pushl  -0x18(%ebp)
     187:	ff 75 08             	pushl  0x8(%ebp)
     18a:	ff 75 f0             	pushl  -0x10(%ebp)
     18d:	68 60 17 00 00       	push   $0x1760
     192:	6a 02                	push   $0x2
     194:	e8 f5 10 00 00       	call   128e <printf>
     199:	83 c4 20             	add    $0x20,%esp
          pre_uid, new_val, post_uid, expected_get_val);
    success = -1;
     19c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  return success;
     1a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     1a6:	c9                   	leave  
     1a7:	c3                   	ret    

000001a8 <testuidgid>:

static void
testuidgid(void)
{
     1a8:	55                   	push   %ebp
     1a9:	89 e5                	mov    %esp,%ebp
     1ab:	83 ec 18             	sub    $0x18,%esp
  int uid, gid;
  int success = 0;
     1ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  printf(1, "\n----------\nRunning UID / GID Tests\n----------\n");
     1b5:	83 ec 08             	sub    $0x8,%esp
     1b8:	68 ac 17 00 00       	push   $0x17ac
     1bd:	6a 01                	push   $0x1
     1bf:	e8 ca 10 00 00       	call   128e <printf>
     1c4:	83 c4 10             	add    $0x10,%esp
  uid = getuid();
     1c7:	e8 bb 0f 00 00       	call   1187 <getuid>
     1cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(uid < 0 || uid > 32767){
     1cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1d3:	78 09                	js     1de <testuidgid+0x36>
     1d5:	81 7d f0 ff 7f 00 00 	cmpl   $0x7fff,-0x10(%ebp)
     1dc:	7e 1c                	jle    1fa <testuidgid+0x52>
    printf(1, "FAILED: Default UID %d, out of range\n", uid);
     1de:	83 ec 04             	sub    $0x4,%esp
     1e1:	ff 75 f0             	pushl  -0x10(%ebp)
     1e4:	68 dc 17 00 00       	push   $0x17dc
     1e9:	6a 01                	push   $0x1
     1eb:	e8 9e 10 00 00       	call   128e <printf>
     1f0:	83 c4 10             	add    $0x10,%esp
    success = -1;
     1f3:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  if (testuid(0, 0, 0))
     1fa:	83 ec 04             	sub    $0x4,%esp
     1fd:	6a 00                	push   $0x0
     1ff:	6a 00                	push   $0x0
     201:	6a 00                	push   $0x0
     203:	e8 06 ff ff ff       	call   10e <testuid>
     208:	83 c4 10             	add    $0x10,%esp
     20b:	85 c0                	test   %eax,%eax
     20d:	74 07                	je     216 <testuidgid+0x6e>
    success = -1;
     20f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(5, 5, 0))
     216:	83 ec 04             	sub    $0x4,%esp
     219:	6a 00                	push   $0x0
     21b:	6a 05                	push   $0x5
     21d:	6a 05                	push   $0x5
     21f:	e8 ea fe ff ff       	call   10e <testuid>
     224:	83 c4 10             	add    $0x10,%esp
     227:	85 c0                	test   %eax,%eax
     229:	74 07                	je     232 <testuidgid+0x8a>
    success = -1;
     22b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(32767, 32767, 0))
     232:	83 ec 04             	sub    $0x4,%esp
     235:	6a 00                	push   $0x0
     237:	68 ff 7f 00 00       	push   $0x7fff
     23c:	68 ff 7f 00 00       	push   $0x7fff
     241:	e8 c8 fe ff ff       	call   10e <testuid>
     246:	83 c4 10             	add    $0x10,%esp
     249:	85 c0                	test   %eax,%eax
     24b:	74 07                	je     254 <testuidgid+0xac>
    success = -1;
     24d:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(32768, 32767, -1))
     254:	83 ec 04             	sub    $0x4,%esp
     257:	6a ff                	push   $0xffffffff
     259:	68 ff 7f 00 00       	push   $0x7fff
     25e:	68 00 80 00 00       	push   $0x8000
     263:	e8 a6 fe ff ff       	call   10e <testuid>
     268:	83 c4 10             	add    $0x10,%esp
     26b:	85 c0                	test   %eax,%eax
     26d:	74 07                	je     276 <testuidgid+0xce>
    success = -1;
     26f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(-1, 32767, -1))
     276:	83 ec 04             	sub    $0x4,%esp
     279:	6a ff                	push   $0xffffffff
     27b:	68 ff 7f 00 00       	push   $0x7fff
     280:	6a ff                	push   $0xffffffff
     282:	e8 87 fe ff ff       	call   10e <testuid>
     287:	83 c4 10             	add    $0x10,%esp
     28a:	85 c0                	test   %eax,%eax
     28c:	74 07                	je     295 <testuidgid+0xed>
    success = -1;
     28e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
 
  gid = getgid();
     295:	e8 f5 0e 00 00       	call   118f <getgid>
     29a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(gid < 0 || gid > 32767){
     29d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2a1:	78 09                	js     2ac <testuidgid+0x104>
     2a3:	81 7d ec ff 7f 00 00 	cmpl   $0x7fff,-0x14(%ebp)
     2aa:	7e 1c                	jle    2c8 <testuidgid+0x120>
    printf(1, "FAILED: Default GID %d, out of range\n", gid);
     2ac:	83 ec 04             	sub    $0x4,%esp
     2af:	ff 75 ec             	pushl  -0x14(%ebp)
     2b2:	68 04 18 00 00       	push   $0x1804
     2b7:	6a 01                	push   $0x1
     2b9:	e8 d0 0f 00 00       	call   128e <printf>
     2be:	83 c4 10             	add    $0x10,%esp
    success = -1;
     2c1:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  if (testgid(0, 0, 0))
     2c8:	83 ec 04             	sub    $0x4,%esp
     2cb:	6a 00                	push   $0x0
     2cd:	6a 00                	push   $0x0
     2cf:	6a 00                	push   $0x0
     2d1:	e8 9e fd ff ff       	call   74 <testgid>
     2d6:	83 c4 10             	add    $0x10,%esp
     2d9:	85 c0                	test   %eax,%eax
     2db:	74 07                	je     2e4 <testuidgid+0x13c>
    success = -1;
     2dd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(5, 5, 0))
     2e4:	83 ec 04             	sub    $0x4,%esp
     2e7:	6a 00                	push   $0x0
     2e9:	6a 05                	push   $0x5
     2eb:	6a 05                	push   $0x5
     2ed:	e8 82 fd ff ff       	call   74 <testgid>
     2f2:	83 c4 10             	add    $0x10,%esp
     2f5:	85 c0                	test   %eax,%eax
     2f7:	74 07                	je     300 <testuidgid+0x158>
    success = -1;
     2f9:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(32767, 32767, 0))
     300:	83 ec 04             	sub    $0x4,%esp
     303:	6a 00                	push   $0x0
     305:	68 ff 7f 00 00       	push   $0x7fff
     30a:	68 ff 7f 00 00       	push   $0x7fff
     30f:	e8 60 fd ff ff       	call   74 <testgid>
     314:	83 c4 10             	add    $0x10,%esp
     317:	85 c0                	test   %eax,%eax
     319:	74 07                	je     322 <testuidgid+0x17a>
    success = -1;
     31b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(-1, 32767, -1))
     322:	83 ec 04             	sub    $0x4,%esp
     325:	6a ff                	push   $0xffffffff
     327:	68 ff 7f 00 00       	push   $0x7fff
     32c:	6a ff                	push   $0xffffffff
     32e:	e8 41 fd ff ff       	call   74 <testgid>
     333:	83 c4 10             	add    $0x10,%esp
     336:	85 c0                	test   %eax,%eax
     338:	74 07                	je     341 <testuidgid+0x199>
    success = -1;
     33a:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(32768, 32767, -1))
     341:	83 ec 04             	sub    $0x4,%esp
     344:	6a ff                	push   $0xffffffff
     346:	68 ff 7f 00 00       	push   $0x7fff
     34b:	68 00 80 00 00       	push   $0x8000
     350:	e8 1f fd ff ff       	call   74 <testgid>
     355:	83 c4 10             	add    $0x10,%esp
     358:	85 c0                	test   %eax,%eax
     35a:	74 07                	je     363 <testuidgid+0x1bb>
    success = -1;
     35c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
 
  if (success == 0)
     363:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     367:	75 12                	jne    37b <testuidgid+0x1d3>
    printf(1, "** All tests passed! **\n");
     369:	83 ec 08             	sub    $0x8,%esp
     36c:	68 2a 18 00 00       	push   $0x182a
     371:	6a 01                	push   $0x1
     373:	e8 16 0f 00 00       	call   128e <printf>
     378:	83 c4 10             	add    $0x10,%esp
}
     37b:	90                   	nop
     37c:	c9                   	leave  
     37d:	c3                   	ret    

0000037e <testuidgidinheritance>:

static void
testuidgidinheritance(void){
     37e:	55                   	push   %ebp
     37f:	89 e5                	mov    %esp,%ebp
     381:	83 ec 18             	sub    $0x18,%esp
  int ret, success, uid, gid;
  success = 0;
     384:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  printf(1, "\n----------\nRunning UID / GID Inheritance Test\n----------\n");
     38b:	83 ec 08             	sub    $0x8,%esp
     38e:	68 44 18 00 00       	push   $0x1844
     393:	6a 01                	push   $0x1
     395:	e8 f4 0e 00 00       	call   128e <printf>
     39a:	83 c4 10             	add    $0x10,%esp
  if (testuid(12345, 12345, 0))
     39d:	83 ec 04             	sub    $0x4,%esp
     3a0:	6a 00                	push   $0x0
     3a2:	68 39 30 00 00       	push   $0x3039
     3a7:	68 39 30 00 00       	push   $0x3039
     3ac:	e8 5d fd ff ff       	call   10e <testuid>
     3b1:	83 c4 10             	add    $0x10,%esp
     3b4:	85 c0                	test   %eax,%eax
     3b6:	74 07                	je     3bf <testuidgidinheritance+0x41>
    success = -1;
     3b8:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(12345, 12345, 0))
     3bf:	83 ec 04             	sub    $0x4,%esp
     3c2:	6a 00                	push   $0x0
     3c4:	68 39 30 00 00       	push   $0x3039
     3c9:	68 39 30 00 00       	push   $0x3039
     3ce:	e8 a1 fc ff ff       	call   74 <testgid>
     3d3:	83 c4 10             	add    $0x10,%esp
     3d6:	85 c0                	test   %eax,%eax
     3d8:	74 07                	je     3e1 <testuidgidinheritance+0x63>
    success = -1;
     3da:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if(success != 0)
     3e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3e5:	75 7c                	jne    463 <testuidgidinheritance+0xe5>
    return;

  ret = fork();
     3e7:	e8 e3 0c 00 00       	call   10cf <fork>
     3ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(ret == 0){
     3ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3f3:	75 67                	jne    45c <testuidgidinheritance+0xde>
    uid = getuid();
     3f5:	e8 8d 0d 00 00       	call   1187 <getuid>
     3fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    gid = getgid();
     3fd:	e8 8d 0d 00 00       	call   118f <getgid>
     402:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(uid != 12345){
     405:	81 7d ec 39 30 00 00 	cmpl   $0x3039,-0x14(%ebp)
     40c:	74 17                	je     425 <testuidgidinheritance+0xa7>
      printf(2, "FAILED: Parent UID is 12345, child UID is %d\n", uid);
     40e:	83 ec 04             	sub    $0x4,%esp
     411:	ff 75 ec             	pushl  -0x14(%ebp)
     414:	68 80 18 00 00       	push   $0x1880
     419:	6a 02                	push   $0x2
     41b:	e8 6e 0e 00 00       	call   128e <printf>
     420:	83 c4 10             	add    $0x10,%esp
     423:	eb 32                	jmp    457 <testuidgidinheritance+0xd9>
    }
    else if(gid != 12345){
     425:	81 7d e8 39 30 00 00 	cmpl   $0x3039,-0x18(%ebp)
     42c:	74 17                	je     445 <testuidgidinheritance+0xc7>
      printf(2, "FAILED: Parent GID is 12345, child GID is %d\n", gid);
     42e:	83 ec 04             	sub    $0x4,%esp
     431:	ff 75 e8             	pushl  -0x18(%ebp)
     434:	68 b0 18 00 00       	push   $0x18b0
     439:	6a 02                	push   $0x2
     43b:	e8 4e 0e 00 00       	call   128e <printf>
     440:	83 c4 10             	add    $0x10,%esp
     443:	eb 12                	jmp    457 <testuidgidinheritance+0xd9>
    }
    else
      printf(1, "** Test Passed! **\n"); 
     445:	83 ec 08             	sub    $0x8,%esp
     448:	68 de 18 00 00       	push   $0x18de
     44d:	6a 01                	push   $0x1
     44f:	e8 3a 0e 00 00       	call   128e <printf>
     454:	83 c4 10             	add    $0x10,%esp
    exit();
     457:	e8 7b 0c 00 00       	call   10d7 <exit>
  }
  else {
    wait();
     45c:	e8 7e 0c 00 00       	call   10df <wait>
     461:	eb 01                	jmp    464 <testuidgidinheritance+0xe6>
  if (testuid(12345, 12345, 0))
    success = -1;
  if (testgid(12345, 12345, 0))
    success = -1;
  if(success != 0)
    return;
     463:	90                   	nop
    exit();
  }
  else {
    wait();
  }
}
     464:	c9                   	leave  
     465:	c3                   	ret    

00000466 <getcputime>:
#ifdef GETPROCS_TEST
#ifdef CPUTIME_TEST
// Simple test to have the program sleep for 200 milliseconds to see if CPU_time properly doesn't change
// And then gets CPU_time again to see if elapsed CPU_total_ticks is reasonable
static int
getcputime(char * name, struct uproc * table){
     466:	55                   	push   %ebp
     467:	89 e5                	mov    %esp,%ebp
     469:	83 ec 18             	sub    $0x18,%esp
  struct uproc *p = 0;
     46c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  int size;
  
  size = getprocs(64, table);
     473:	83 ec 08             	sub    $0x8,%esp
     476:	ff 75 0c             	pushl  0xc(%ebp)
     479:	6a 40                	push   $0x40
     47b:	e8 2f 0d 00 00       	call   11af <getprocs>
     480:	83 c4 10             	add    $0x10,%esp
     483:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(int i = 0; i < size; ++i){
     486:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     48d:	eb 47                	jmp    4d6 <getcputime+0x70>
    if(strcmp(table[i].name, name) == 0){
     48f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     492:	c1 e0 03             	shl    $0x3,%eax
     495:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     49c:	29 c2                	sub    %eax,%edx
     49e:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a1:	01 d0                	add    %edx,%eax
     4a3:	83 c0 28             	add    $0x28,%eax
     4a6:	83 ec 08             	sub    $0x8,%esp
     4a9:	ff 75 08             	pushl  0x8(%ebp)
     4ac:	50                   	push   %eax
     4ad:	e8 51 09 00 00       	call   e03 <strcmp>
     4b2:	83 c4 10             	add    $0x10,%esp
     4b5:	85 c0                	test   %eax,%eax
     4b7:	75 19                	jne    4d2 <getcputime+0x6c>
      p = table + i;
     4b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4bc:	c1 e0 03             	shl    $0x3,%eax
     4bf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     4c6:	29 c2                	sub    %eax,%edx
     4c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     4cb:	01 d0                	add    %edx,%eax
     4cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      break;
     4d0:	eb 0c                	jmp    4de <getcputime+0x78>
getcputime(char * name, struct uproc * table){
  struct uproc *p = 0;
  int size;
  
  size = getprocs(64, table);
  for(int i = 0; i < size; ++i){
     4d2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     4d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4d9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     4dc:	7c b1                	jl     48f <getcputime+0x29>
    if(strcmp(table[i].name, name) == 0){
      p = table + i;
      break;
    }
  }
  if(p == 0){
     4de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4e2:	75 1c                	jne    500 <getcputime+0x9a>
    printf(2, "FAILED: Test program \"%s\" not found in table returned by getprocs\n", name);
     4e4:	83 ec 04             	sub    $0x4,%esp
     4e7:	ff 75 08             	pushl  0x8(%ebp)
     4ea:	68 f4 18 00 00       	push   $0x18f4
     4ef:	6a 02                	push   $0x2
     4f1:	e8 98 0d 00 00       	call   128e <printf>
     4f6:	83 c4 10             	add    $0x10,%esp
    return -1;
     4f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4fe:	eb 06                	jmp    506 <getcputime+0xa0>
  }
  else
    return (int) p->cpu_ticks_total;
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
     503:	8b 40 14             	mov    0x14(%eax),%eax
}
     506:	c9                   	leave  
     507:	c3                   	ret    

00000508 <testcputime>:

static void
testcputime(char * name){
     508:	55                   	push   %ebp
     509:	89 e5                	mov    %esp,%ebp
     50b:	83 ec 28             	sub    $0x28,%esp
  struct uproc *table;
  uint time1, time2, pre_sleep, post_sleep;
  int success = 0;
     50e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  int i, num;

  printf(1, "\n----------\nRunning CPU Time Test\n----------\n");
     515:	83 ec 08             	sub    $0x8,%esp
     518:	68 38 19 00 00       	push   $0x1938
     51d:	6a 01                	push   $0x1
     51f:	e8 6a 0d 00 00       	call   128e <printf>
     524:	83 c4 10             	add    $0x10,%esp
  table = malloc(sizeof(struct uproc) * 64);
     527:	83 ec 0c             	sub    $0xc,%esp
     52a:	68 00 0e 00 00       	push   $0xe00
     52f:	e8 2d 10 00 00       	call   1561 <malloc>
     534:	83 c4 10             	add    $0x10,%esp
     537:	89 45 e8             	mov    %eax,-0x18(%ebp)
  printf(1, "This will take a couple seconds\n");
     53a:	83 ec 08             	sub    $0x8,%esp
     53d:	68 68 19 00 00       	push   $0x1968
     542:	6a 01                	push   $0x1
     544:	e8 45 0d 00 00       	call   128e <printf>
     549:	83 c4 10             	add    $0x10,%esp

  // Loop for a long time to see if the elapsed CPU_total_ticks is in a reasonable range
  time1 = getcputime(name, table);
     54c:	83 ec 08             	sub    $0x8,%esp
     54f:	ff 75 e8             	pushl  -0x18(%ebp)
     552:	ff 75 08             	pushl  0x8(%ebp)
     555:	e8 0c ff ff ff       	call   466 <getcputime>
     55a:	83 c4 10             	add    $0x10,%esp
     55d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0, num = 0; i < 1000000; ++i){
     560:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     567:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     56e:	e9 8a 00 00 00       	jmp    5fd <testcputime+0xf5>
    ++num;
     573:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    if(num % 100000 == 0){
     577:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     57a:	ba 89 b5 f8 14       	mov    $0x14f8b589,%edx
     57f:	89 c8                	mov    %ecx,%eax
     581:	f7 ea                	imul   %edx
     583:	c1 fa 0d             	sar    $0xd,%edx
     586:	89 c8                	mov    %ecx,%eax
     588:	c1 f8 1f             	sar    $0x1f,%eax
     58b:	29 c2                	sub    %eax,%edx
     58d:	89 d0                	mov    %edx,%eax
     58f:	69 c0 a0 86 01 00    	imul   $0x186a0,%eax,%eax
     595:	29 c1                	sub    %eax,%ecx
     597:	89 c8                	mov    %ecx,%eax
     599:	85 c0                	test   %eax,%eax
     59b:	75 5c                	jne    5f9 <testcputime+0xf1>
      pre_sleep = getcputime(name, table);
     59d:	83 ec 08             	sub    $0x8,%esp
     5a0:	ff 75 e8             	pushl  -0x18(%ebp)
     5a3:	ff 75 08             	pushl  0x8(%ebp)
     5a6:	e8 bb fe ff ff       	call   466 <getcputime>
     5ab:	83 c4 10             	add    $0x10,%esp
     5ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
      sleep(200);
     5b1:	83 ec 0c             	sub    $0xc,%esp
     5b4:	68 c8 00 00 00       	push   $0xc8
     5b9:	e8 a9 0b 00 00       	call   1167 <sleep>
     5be:	83 c4 10             	add    $0x10,%esp
      post_sleep = getcputime(name, table);
     5c1:	83 ec 08             	sub    $0x8,%esp
     5c4:	ff 75 e8             	pushl  -0x18(%ebp)
     5c7:	ff 75 08             	pushl  0x8(%ebp)
     5ca:	e8 97 fe ff ff       	call   466 <getcputime>
     5cf:	83 c4 10             	add    $0x10,%esp
     5d2:	89 45 dc             	mov    %eax,-0x24(%ebp)
      if((post_sleep - pre_sleep) >= 100){
     5d5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     5d8:	2b 45 e0             	sub    -0x20(%ebp),%eax
     5db:	83 f8 63             	cmp    $0x63,%eax
     5de:	76 19                	jbe    5f9 <testcputime+0xf1>
        printf(2, "FAILED: CPU_total_ticks changed by 100+ milliseconds while process was asleep\n");
     5e0:	83 ec 08             	sub    $0x8,%esp
     5e3:	68 8c 19 00 00       	push   $0x198c
     5e8:	6a 02                	push   $0x2
     5ea:	e8 9f 0c 00 00       	call   128e <printf>
     5ef:	83 c4 10             	add    $0x10,%esp
        success = -1;
     5f2:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  table = malloc(sizeof(struct uproc) * 64);
  printf(1, "This will take a couple seconds\n");

  // Loop for a long time to see if the elapsed CPU_total_ticks is in a reasonable range
  time1 = getcputime(name, table);
  for(i = 0, num = 0; i < 1000000; ++i){
     5f9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5fd:	81 7d f0 3f 42 0f 00 	cmpl   $0xf423f,-0x10(%ebp)
     604:	0f 8e 69 ff ff ff    	jle    573 <testcputime+0x6b>
        printf(2, "FAILED: CPU_total_ticks changed by 100+ milliseconds while process was asleep\n");
        success = -1;
      }
    }
  }
  time2 = getcputime(name, table);
     60a:	83 ec 08             	sub    $0x8,%esp
     60d:	ff 75 e8             	pushl  -0x18(%ebp)
     610:	ff 75 08             	pushl  0x8(%ebp)
     613:	e8 4e fe ff ff       	call   466 <getcputime>
     618:	83 c4 10             	add    $0x10,%esp
     61b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if((time2 - time1) < 0){
    printf(2, "FAILED: difference in CPU_total_ticks is negative.  T2 - T1 = %d\n", (time2 - time1));
    success = -1;
  }
  if((time2 - time1) > 400){
     61e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     621:	2b 45 e4             	sub    -0x1c(%ebp),%eax
     624:	3d 90 01 00 00       	cmp    $0x190,%eax
     629:	76 20                	jbe    64b <testcputime+0x143>
    printf(2, "ABNORMALLY HIGH: T2 - T1 = %d milliseconds.  Run test again\n", (time2 - time1));
     62b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     62e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
     631:	83 ec 04             	sub    $0x4,%esp
     634:	50                   	push   %eax
     635:	68 dc 19 00 00       	push   $0x19dc
     63a:	6a 02                	push   $0x2
     63c:	e8 4d 0c 00 00       	call   128e <printf>
     641:	83 c4 10             	add    $0x10,%esp
    success = -1; 
     644:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  printf(1, "T2 - T1 = %d milliseconds\n", (time2 - time1));
     64b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     64e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
     651:	83 ec 04             	sub    $0x4,%esp
     654:	50                   	push   %eax
     655:	68 19 1a 00 00       	push   $0x1a19
     65a:	6a 01                	push   $0x1
     65c:	e8 2d 0c 00 00       	call   128e <printf>
     661:	83 c4 10             	add    $0x10,%esp
  free(table);
     664:	83 ec 0c             	sub    $0xc,%esp
     667:	ff 75 e8             	pushl  -0x18(%ebp)
     66a:	e8 b0 0d 00 00       	call   141f <free>
     66f:	83 c4 10             	add    $0x10,%esp

  if(success == 0)
     672:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     676:	75 12                	jne    68a <testcputime+0x182>
    printf(1, "** All Tests Passed! **\n");
     678:	83 ec 08             	sub    $0x8,%esp
     67b:	68 34 1a 00 00       	push   $0x1a34
     680:	6a 01                	push   $0x1
     682:	e8 07 0c 00 00       	call   128e <printf>
     687:	83 c4 10             	add    $0x10,%esp
}
     68a:	90                   	nop
     68b:	c9                   	leave  
     68c:	c3                   	ret    

0000068d <testprocarray>:

#ifdef GETPROCS_TEST
// Fork to 64 process and then make sure we get all when passing table array
// of sizes 1, 16, 64, 72
static int
testprocarray(int max, int expected_ret, char * name){
     68d:	55                   	push   %ebp
     68e:	89 e5                	mov    %esp,%ebp
     690:	83 ec 28             	sub    $0x28,%esp
  struct uproc * table;
  int ret, success, num_init, num_sh, num_this;
  success = num_init = num_sh = num_this = 0;
     693:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
     69a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     69d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     6a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  table = malloc(sizeof(struct uproc) * max);
     6ac:	8b 45 08             	mov    0x8(%ebp),%eax
     6af:	c1 e0 03             	shl    $0x3,%eax
     6b2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6b9:	29 c2                	sub    %eax,%edx
     6bb:	89 d0                	mov    %edx,%eax
     6bd:	83 ec 0c             	sub    $0xc,%esp
     6c0:	50                   	push   %eax
     6c1:	e8 9b 0e 00 00       	call   1561 <malloc>
     6c6:	83 c4 10             	add    $0x10,%esp
     6c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  ret = getprocs(max, table);
     6cc:	8b 45 08             	mov    0x8(%ebp),%eax
     6cf:	83 ec 08             	sub    $0x8,%esp
     6d2:	ff 75 e0             	pushl  -0x20(%ebp)
     6d5:	50                   	push   %eax
     6d6:	e8 d4 0a 00 00       	call   11af <getprocs>
     6db:	83 c4 10             	add    $0x10,%esp
     6de:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for (int i = 0; i < ret; ++i){
     6e1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     6e8:	e9 96 00 00 00       	jmp    783 <testprocarray+0xf6>
    if(strcmp(table[i].name, "init") == 0)
     6ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6f0:	c1 e0 03             	shl    $0x3,%eax
     6f3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6fa:	29 c2                	sub    %eax,%edx
     6fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     6ff:	01 d0                	add    %edx,%eax
     701:	83 c0 28             	add    $0x28,%eax
     704:	83 ec 08             	sub    $0x8,%esp
     707:	68 4d 1a 00 00       	push   $0x1a4d
     70c:	50                   	push   %eax
     70d:	e8 f1 06 00 00       	call   e03 <strcmp>
     712:	83 c4 10             	add    $0x10,%esp
     715:	85 c0                	test   %eax,%eax
     717:	75 06                	jne    71f <testprocarray+0x92>
      ++num_init;
     719:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     71d:	eb 60                	jmp    77f <testprocarray+0xf2>
    else if(strcmp(table[i].name, "sh") == 0)
     71f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     722:	c1 e0 03             	shl    $0x3,%eax
     725:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     72c:	29 c2                	sub    %eax,%edx
     72e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     731:	01 d0                	add    %edx,%eax
     733:	83 c0 28             	add    $0x28,%eax
     736:	83 ec 08             	sub    $0x8,%esp
     739:	68 52 1a 00 00       	push   $0x1a52
     73e:	50                   	push   %eax
     73f:	e8 bf 06 00 00       	call   e03 <strcmp>
     744:	83 c4 10             	add    $0x10,%esp
     747:	85 c0                	test   %eax,%eax
     749:	75 06                	jne    751 <testprocarray+0xc4>
      ++num_sh;
     74b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     74f:	eb 2e                	jmp    77f <testprocarray+0xf2>
    else if(strcmp(table[i].name, name) == 0)
     751:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     754:	c1 e0 03             	shl    $0x3,%eax
     757:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     75e:	29 c2                	sub    %eax,%edx
     760:	8b 45 e0             	mov    -0x20(%ebp),%eax
     763:	01 d0                	add    %edx,%eax
     765:	83 c0 28             	add    $0x28,%eax
     768:	83 ec 08             	sub    $0x8,%esp
     76b:	ff 75 10             	pushl  0x10(%ebp)
     76e:	50                   	push   %eax
     76f:	e8 8f 06 00 00       	call   e03 <strcmp>
     774:	83 c4 10             	add    $0x10,%esp
     777:	85 c0                	test   %eax,%eax
     779:	75 04                	jne    77f <testprocarray+0xf2>
      ++num_this;
     77b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  int ret, success, num_init, num_sh, num_this;
  success = num_init = num_sh = num_this = 0;
  
  table = malloc(sizeof(struct uproc) * max);
  ret = getprocs(max, table);
  for (int i = 0; i < ret; ++i){
     77f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     783:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     786:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     789:	0f 8c 5e ff ff ff    	jl     6ed <testprocarray+0x60>
    else if(strcmp(table[i].name, "sh") == 0)
      ++num_sh;
    else if(strcmp(table[i].name, name) == 0)
      ++num_this;
  }
  if (ret != expected_ret){
     78f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     792:	3b 45 0c             	cmp    0xc(%ebp),%eax
     795:	74 24                	je     7bb <testprocarray+0x12e>
    printf(2, "FAILED: getprocs(%d) returned %d, expected %d\n", max, ret, expected_ret);
     797:	83 ec 0c             	sub    $0xc,%esp
     79a:	ff 75 0c             	pushl  0xc(%ebp)
     79d:	ff 75 dc             	pushl  -0x24(%ebp)
     7a0:	ff 75 08             	pushl  0x8(%ebp)
     7a3:	68 58 1a 00 00       	push   $0x1a58
     7a8:	6a 02                	push   $0x2
     7aa:	e8 df 0a 00 00       	call   128e <printf>
     7af:	83 c4 20             	add    $0x20,%esp
    success = -1;
     7b2:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
     7b9:	eb 21                	jmp    7dc <testprocarray+0x14f>
  }
  else{
    printf(1, "getprocs(%d), found %d processes with names(qty), \"init\"(%d), \"sh\"(%d), \"%s\"(%d)\n",
     7bb:	ff 75 e8             	pushl  -0x18(%ebp)
     7be:	ff 75 10             	pushl  0x10(%ebp)
     7c1:	ff 75 ec             	pushl  -0x14(%ebp)
     7c4:	ff 75 f0             	pushl  -0x10(%ebp)
     7c7:	ff 75 dc             	pushl  -0x24(%ebp)
     7ca:	ff 75 08             	pushl  0x8(%ebp)
     7cd:	68 88 1a 00 00       	push   $0x1a88
     7d2:	6a 01                	push   $0x1
     7d4:	e8 b5 0a 00 00       	call   128e <printf>
     7d9:	83 c4 20             	add    $0x20,%esp
            max, ret, num_init, num_sh, name, num_this);
  }
  free(table);
     7dc:	83 ec 0c             	sub    $0xc,%esp
     7df:	ff 75 e0             	pushl  -0x20(%ebp)
     7e2:	e8 38 0c 00 00       	call   141f <free>
     7e7:	83 c4 10             	add    $0x10,%esp
  return success;
     7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     7ed:	c9                   	leave  
     7ee:	c3                   	ret    

000007ef <testinvalidarray>:

static int
testinvalidarray(void){
     7ef:	55                   	push   %ebp
     7f0:	89 e5                	mov    %esp,%ebp
     7f2:	83 ec 18             	sub    $0x18,%esp
  struct uproc * table;
  int ret;

  table = malloc(sizeof(struct uproc));
     7f5:	83 ec 0c             	sub    $0xc,%esp
     7f8:	6a 38                	push   $0x38
     7fa:	e8 62 0d 00 00       	call   1561 <malloc>
     7ff:	83 c4 10             	add    $0x10,%esp
     802:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ret = getprocs(1024, table);
     805:	83 ec 08             	sub    $0x8,%esp
     808:	ff 75 f4             	pushl  -0xc(%ebp)
     80b:	68 00 04 00 00       	push   $0x400
     810:	e8 9a 09 00 00       	call   11af <getprocs>
     815:	83 c4 10             	add    $0x10,%esp
     818:	89 45 f0             	mov    %eax,-0x10(%ebp)
  free(table);
     81b:	83 ec 0c             	sub    $0xc,%esp
     81e:	ff 75 f4             	pushl  -0xc(%ebp)
     821:	e8 f9 0b 00 00       	call   141f <free>
     826:	83 c4 10             	add    $0x10,%esp
  if(ret >= 0){
     829:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     82d:	78 1c                	js     84b <testinvalidarray+0x5c>
    printf(2, "FAILED: called getprocs with max way larger than table and returned %d, not error\n", ret);
     82f:	83 ec 04             	sub    $0x4,%esp
     832:	ff 75 f0             	pushl  -0x10(%ebp)
     835:	68 dc 1a 00 00       	push   $0x1adc
     83a:	6a 02                	push   $0x2
     83c:	e8 4d 0a 00 00       	call   128e <printf>
     841:	83 c4 10             	add    $0x10,%esp
    return -1;
     844:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     849:	eb 05                	jmp    850 <testinvalidarray+0x61>
  }
  return 0;
     84b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     850:	c9                   	leave  
     851:	c3                   	ret    

00000852 <testgetprocs>:

static void
testgetprocs(char * name){
     852:	55                   	push   %ebp
     853:	89 e5                	mov    %esp,%ebp
     855:	83 ec 18             	sub    $0x18,%esp
  int ret, success;

  printf(1, "\n----------\nRunning GetProcs Test\n----------\n");
     858:	83 ec 08             	sub    $0x8,%esp
     85b:	68 30 1b 00 00       	push   $0x1b30
     860:	6a 01                	push   $0x1
     862:	e8 27 0a 00 00       	call   128e <printf>
     867:	83 c4 10             	add    $0x10,%esp
  // Fork until no space left in ptable
  ret = fork();
     86a:	e8 60 08 00 00       	call   10cf <fork>
     86f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if (ret == 0){
     872:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     876:	0f 85 c6 00 00 00    	jne    942 <testgetprocs+0xf0>
    while((ret = fork()) == 0);
     87c:	e8 4e 08 00 00       	call   10cf <fork>
     881:	89 45 f0             	mov    %eax,-0x10(%ebp)
     884:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     888:	74 f2                	je     87c <testgetprocs+0x2a>
    if(ret > 0){
     88a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     88e:	7e 0a                	jle    89a <testgetprocs+0x48>
      wait();
     890:	e8 4a 08 00 00       	call   10df <wait>
      exit();
     895:	e8 3d 08 00 00       	call   10d7 <exit>
    }
    // Only return left is -1, which is no space left in ptable
    success = 0;
     89a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(testinvalidarray())
     8a1:	e8 49 ff ff ff       	call   7ef <testinvalidarray>
     8a6:	85 c0                	test   %eax,%eax
     8a8:	74 07                	je     8b1 <testgetprocs+0x5f>
      success = -1;
     8aa:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    if(testprocarray(1, 1, name))
     8b1:	83 ec 04             	sub    $0x4,%esp
     8b4:	ff 75 08             	pushl  0x8(%ebp)
     8b7:	6a 01                	push   $0x1
     8b9:	6a 01                	push   $0x1
     8bb:	e8 cd fd ff ff       	call   68d <testprocarray>
     8c0:	83 c4 10             	add    $0x10,%esp
     8c3:	85 c0                	test   %eax,%eax
     8c5:	74 07                	je     8ce <testgetprocs+0x7c>
      success = -1;
     8c7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    if(testprocarray(16, 16, name))
     8ce:	83 ec 04             	sub    $0x4,%esp
     8d1:	ff 75 08             	pushl  0x8(%ebp)
     8d4:	6a 10                	push   $0x10
     8d6:	6a 10                	push   $0x10
     8d8:	e8 b0 fd ff ff       	call   68d <testprocarray>
     8dd:	83 c4 10             	add    $0x10,%esp
     8e0:	85 c0                	test   %eax,%eax
     8e2:	74 07                	je     8eb <testgetprocs+0x99>
      success = -1;
     8e4:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    if(testprocarray(64, 64, name))
     8eb:	83 ec 04             	sub    $0x4,%esp
     8ee:	ff 75 08             	pushl  0x8(%ebp)
     8f1:	6a 40                	push   $0x40
     8f3:	6a 40                	push   $0x40
     8f5:	e8 93 fd ff ff       	call   68d <testprocarray>
     8fa:	83 c4 10             	add    $0x10,%esp
     8fd:	85 c0                	test   %eax,%eax
     8ff:	74 07                	je     908 <testgetprocs+0xb6>
      success = -1;
     901:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    if(testprocarray(72, 64, name))
     908:	83 ec 04             	sub    $0x4,%esp
     90b:	ff 75 08             	pushl  0x8(%ebp)
     90e:	6a 40                	push   $0x40
     910:	6a 48                	push   $0x48
     912:	e8 76 fd ff ff       	call   68d <testprocarray>
     917:	83 c4 10             	add    $0x10,%esp
     91a:	85 c0                	test   %eax,%eax
     91c:	74 07                	je     925 <testgetprocs+0xd3>
      success = -1;
     91e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    if (success == 0)
     925:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     929:	75 12                	jne    93d <testgetprocs+0xeb>
      printf(1, "** All Tests Passed **\n");
     92b:	83 ec 08             	sub    $0x8,%esp
     92e:	68 5e 1b 00 00       	push   $0x1b5e
     933:	6a 01                	push   $0x1
     935:	e8 54 09 00 00       	call   128e <printf>
     93a:	83 c4 10             	add    $0x10,%esp
    exit(); 
     93d:	e8 95 07 00 00       	call   10d7 <exit>
  }
  wait();
     942:	e8 98 07 00 00       	call   10df <wait>
}
     947:	90                   	nop
     948:	c9                   	leave  
     949:	c3                   	ret    

0000094a <testtimewitharg>:
#endif

#ifdef TIME_TEST
// Forks a process and execs with time + args to see how it handles no args, invalid args, mulitple args
void
testtimewitharg(char **arg){
     94a:	55                   	push   %ebp
     94b:	89 e5                	mov    %esp,%ebp
     94d:	83 ec 18             	sub    $0x18,%esp
  int ret;
 
  ret = fork();
     950:	e8 7a 07 00 00       	call   10cf <fork>
     955:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (ret == 0){
     958:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     95c:	75 31                	jne    98f <testtimewitharg+0x45>
    exec(arg[0], arg);
     95e:	8b 45 08             	mov    0x8(%ebp),%eax
     961:	8b 00                	mov    (%eax),%eax
     963:	83 ec 08             	sub    $0x8,%esp
     966:	ff 75 08             	pushl  0x8(%ebp)
     969:	50                   	push   %eax
     96a:	e8 a0 07 00 00       	call   110f <exec>
     96f:	83 c4 10             	add    $0x10,%esp
    printf(2, "FAILED: exec failed to execute %s\n", arg[0]);
     972:	8b 45 08             	mov    0x8(%ebp),%eax
     975:	8b 00                	mov    (%eax),%eax
     977:	83 ec 04             	sub    $0x4,%esp
     97a:	50                   	push   %eax
     97b:	68 78 1b 00 00       	push   $0x1b78
     980:	6a 02                	push   $0x2
     982:	e8 07 09 00 00       	call   128e <printf>
     987:	83 c4 10             	add    $0x10,%esp
    exit();
     98a:	e8 48 07 00 00       	call   10d7 <exit>
  }
  else if(ret == -1){
     98f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     993:	75 14                	jne    9a9 <testtimewitharg+0x5f>
    printf(2, "FAILED: fork failed\n");
     995:	83 ec 08             	sub    $0x8,%esp
     998:	68 9b 1b 00 00       	push   $0x1b9b
     99d:	6a 02                	push   $0x2
     99f:	e8 ea 08 00 00       	call   128e <printf>
     9a4:	83 c4 10             	add    $0x10,%esp
  }
  else
    wait();
}
     9a7:	eb 05                	jmp    9ae <testtimewitharg+0x64>
  }
  else if(ret == -1){
    printf(2, "FAILED: fork failed\n");
  }
  else
    wait();
     9a9:	e8 31 07 00 00       	call   10df <wait>
}
     9ae:	90                   	nop
     9af:	c9                   	leave  
     9b0:	c3                   	ret    

000009b1 <testtime>:
void
testtime(void){
     9b1:	55                   	push   %ebp
     9b2:	89 e5                	mov    %esp,%ebp
     9b4:	53                   	push   %ebx
     9b5:	83 ec 14             	sub    $0x14,%esp
  char **arg1 = malloc(sizeof(char *));
     9b8:	83 ec 0c             	sub    $0xc,%esp
     9bb:	6a 04                	push   $0x4
     9bd:	e8 9f 0b 00 00       	call   1561 <malloc>
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char **arg2 = malloc(sizeof(char *)*2);
     9c8:	83 ec 0c             	sub    $0xc,%esp
     9cb:	6a 08                	push   $0x8
     9cd:	e8 8f 0b 00 00       	call   1561 <malloc>
     9d2:	83 c4 10             	add    $0x10,%esp
     9d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  char **arg3 = malloc(sizeof(char *)*2);
     9d8:	83 ec 0c             	sub    $0xc,%esp
     9db:	6a 08                	push   $0x8
     9dd:	e8 7f 0b 00 00       	call   1561 <malloc>
     9e2:	83 c4 10             	add    $0x10,%esp
     9e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  char **arg4 = malloc(sizeof(char *)*4);
     9e8:	83 ec 0c             	sub    $0xc,%esp
     9eb:	6a 10                	push   $0x10
     9ed:	e8 6f 0b 00 00       	call   1561 <malloc>
     9f2:	83 c4 10             	add    $0x10,%esp
     9f5:	89 45 e8             	mov    %eax,-0x18(%ebp)

  arg1[0] = malloc(sizeof(char) * 5);
     9f8:	83 ec 0c             	sub    $0xc,%esp
     9fb:	6a 05                	push   $0x5
     9fd:	e8 5f 0b 00 00       	call   1561 <malloc>
     a02:	83 c4 10             	add    $0x10,%esp
     a05:	89 c2                	mov    %eax,%edx
     a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0a:	89 10                	mov    %edx,(%eax)
  strcpy(arg1[0], "time");
     a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0f:	8b 00                	mov    (%eax),%eax
     a11:	83 ec 08             	sub    $0x8,%esp
     a14:	68 b0 1b 00 00       	push   $0x1bb0
     a19:	50                   	push   %eax
     a1a:	e8 b4 03 00 00       	call   dd3 <strcpy>
     a1f:	83 c4 10             	add    $0x10,%esp

  arg2[0] = malloc(sizeof(char) * 5);
     a22:	83 ec 0c             	sub    $0xc,%esp
     a25:	6a 05                	push   $0x5
     a27:	e8 35 0b 00 00       	call   1561 <malloc>
     a2c:	83 c4 10             	add    $0x10,%esp
     a2f:	89 c2                	mov    %eax,%edx
     a31:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a34:	89 10                	mov    %edx,(%eax)
  strcpy(arg2[0], "time");
     a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a39:	8b 00                	mov    (%eax),%eax
     a3b:	83 ec 08             	sub    $0x8,%esp
     a3e:	68 b0 1b 00 00       	push   $0x1bb0
     a43:	50                   	push   %eax
     a44:	e8 8a 03 00 00       	call   dd3 <strcpy>
     a49:	83 c4 10             	add    $0x10,%esp
  arg2[1] = malloc(sizeof(char) * 4);
     a4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4f:	8d 58 04             	lea    0x4(%eax),%ebx
     a52:	83 ec 0c             	sub    $0xc,%esp
     a55:	6a 04                	push   $0x4
     a57:	e8 05 0b 00 00       	call   1561 <malloc>
     a5c:	83 c4 10             	add    $0x10,%esp
     a5f:	89 03                	mov    %eax,(%ebx)
  strcpy(arg2[1], "abc");
     a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a64:	83 c0 04             	add    $0x4,%eax
     a67:	8b 00                	mov    (%eax),%eax
     a69:	83 ec 08             	sub    $0x8,%esp
     a6c:	68 b5 1b 00 00       	push   $0x1bb5
     a71:	50                   	push   %eax
     a72:	e8 5c 03 00 00       	call   dd3 <strcpy>
     a77:	83 c4 10             	add    $0x10,%esp

  arg3[0] = malloc(sizeof(char) * 5);
     a7a:	83 ec 0c             	sub    $0xc,%esp
     a7d:	6a 05                	push   $0x5
     a7f:	e8 dd 0a 00 00       	call   1561 <malloc>
     a84:	83 c4 10             	add    $0x10,%esp
     a87:	89 c2                	mov    %eax,%edx
     a89:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a8c:	89 10                	mov    %edx,(%eax)
  strcpy(arg3[0], "time");
     a8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a91:	8b 00                	mov    (%eax),%eax
     a93:	83 ec 08             	sub    $0x8,%esp
     a96:	68 b0 1b 00 00       	push   $0x1bb0
     a9b:	50                   	push   %eax
     a9c:	e8 32 03 00 00       	call   dd3 <strcpy>
     aa1:	83 c4 10             	add    $0x10,%esp
  arg3[1] = malloc(sizeof(char) * 5);
     aa4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aa7:	8d 58 04             	lea    0x4(%eax),%ebx
     aaa:	83 ec 0c             	sub    $0xc,%esp
     aad:	6a 05                	push   $0x5
     aaf:	e8 ad 0a 00 00       	call   1561 <malloc>
     ab4:	83 c4 10             	add    $0x10,%esp
     ab7:	89 03                	mov    %eax,(%ebx)
  strcpy(arg3[1], "date");
     ab9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     abc:	83 c0 04             	add    $0x4,%eax
     abf:	8b 00                	mov    (%eax),%eax
     ac1:	83 ec 08             	sub    $0x8,%esp
     ac4:	68 b9 1b 00 00       	push   $0x1bb9
     ac9:	50                   	push   %eax
     aca:	e8 04 03 00 00       	call   dd3 <strcpy>
     acf:	83 c4 10             	add    $0x10,%esp

  arg4[0] = malloc(sizeof(char) * 5);
     ad2:	83 ec 0c             	sub    $0xc,%esp
     ad5:	6a 05                	push   $0x5
     ad7:	e8 85 0a 00 00       	call   1561 <malloc>
     adc:	83 c4 10             	add    $0x10,%esp
     adf:	89 c2                	mov    %eax,%edx
     ae1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ae4:	89 10                	mov    %edx,(%eax)
  strcpy(arg4[0], "time");
     ae6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ae9:	8b 00                	mov    (%eax),%eax
     aeb:	83 ec 08             	sub    $0x8,%esp
     aee:	68 b0 1b 00 00       	push   $0x1bb0
     af3:	50                   	push   %eax
     af4:	e8 da 02 00 00       	call   dd3 <strcpy>
     af9:	83 c4 10             	add    $0x10,%esp
  arg4[1] = malloc(sizeof(char) * 5);
     afc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aff:	8d 58 04             	lea    0x4(%eax),%ebx
     b02:	83 ec 0c             	sub    $0xc,%esp
     b05:	6a 05                	push   $0x5
     b07:	e8 55 0a 00 00       	call   1561 <malloc>
     b0c:	83 c4 10             	add    $0x10,%esp
     b0f:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[1], "time");
     b11:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b14:	83 c0 04             	add    $0x4,%eax
     b17:	8b 00                	mov    (%eax),%eax
     b19:	83 ec 08             	sub    $0x8,%esp
     b1c:	68 b0 1b 00 00       	push   $0x1bb0
     b21:	50                   	push   %eax
     b22:	e8 ac 02 00 00       	call   dd3 <strcpy>
     b27:	83 c4 10             	add    $0x10,%esp
  arg4[2] = malloc(sizeof(char) * 5);
     b2a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b2d:	8d 58 08             	lea    0x8(%eax),%ebx
     b30:	83 ec 0c             	sub    $0xc,%esp
     b33:	6a 05                	push   $0x5
     b35:	e8 27 0a 00 00       	call   1561 <malloc>
     b3a:	83 c4 10             	add    $0x10,%esp
     b3d:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[2], "echo");
     b3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b42:	83 c0 08             	add    $0x8,%eax
     b45:	8b 00                	mov    (%eax),%eax
     b47:	83 ec 08             	sub    $0x8,%esp
     b4a:	68 be 1b 00 00       	push   $0x1bbe
     b4f:	50                   	push   %eax
     b50:	e8 7e 02 00 00       	call   dd3 <strcpy>
     b55:	83 c4 10             	add    $0x10,%esp
  arg4[3] = malloc(sizeof(char) * 6);
     b58:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b5b:	8d 58 0c             	lea    0xc(%eax),%ebx
     b5e:	83 ec 0c             	sub    $0xc,%esp
     b61:	6a 06                	push   $0x6
     b63:	e8 f9 09 00 00       	call   1561 <malloc>
     b68:	83 c4 10             	add    $0x10,%esp
     b6b:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[3], "\"abc\"");
     b6d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b70:	83 c0 0c             	add    $0xc,%eax
     b73:	8b 00                	mov    (%eax),%eax
     b75:	83 ec 08             	sub    $0x8,%esp
     b78:	68 c3 1b 00 00       	push   $0x1bc3
     b7d:	50                   	push   %eax
     b7e:	e8 50 02 00 00       	call   dd3 <strcpy>
     b83:	83 c4 10             	add    $0x10,%esp
 
  printf(1, "\n----------\nRunning Time Test\n----------\n");
     b86:	83 ec 08             	sub    $0x8,%esp
     b89:	68 cc 1b 00 00       	push   $0x1bcc
     b8e:	6a 01                	push   $0x1
     b90:	e8 f9 06 00 00       	call   128e <printf>
     b95:	83 c4 10             	add    $0x10,%esp
  printf(1, "You will need to verify these tests passed\n");
     b98:	83 ec 08             	sub    $0x8,%esp
     b9b:	68 f8 1b 00 00       	push   $0x1bf8
     ba0:	6a 01                	push   $0x1
     ba2:	e8 e7 06 00 00       	call   128e <printf>
     ba7:	83 c4 10             	add    $0x10,%esp

  printf(1,"\n%s\n", arg1[0]);
     baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bad:	8b 00                	mov    (%eax),%eax
     baf:	83 ec 04             	sub    $0x4,%esp
     bb2:	50                   	push   %eax
     bb3:	68 24 1c 00 00       	push   $0x1c24
     bb8:	6a 01                	push   $0x1
     bba:	e8 cf 06 00 00       	call   128e <printf>
     bbf:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg1);
     bc2:	83 ec 0c             	sub    $0xc,%esp
     bc5:	ff 75 f4             	pushl  -0xc(%ebp)
     bc8:	e8 7d fd ff ff       	call   94a <testtimewitharg>
     bcd:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s\n", arg2[0], arg2[1]);
     bd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd3:	83 c0 04             	add    $0x4,%eax
     bd6:	8b 10                	mov    (%eax),%edx
     bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bdb:	8b 00                	mov    (%eax),%eax
     bdd:	52                   	push   %edx
     bde:	50                   	push   %eax
     bdf:	68 29 1c 00 00       	push   $0x1c29
     be4:	6a 01                	push   $0x1
     be6:	e8 a3 06 00 00       	call   128e <printf>
     beb:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg2);
     bee:	83 ec 0c             	sub    $0xc,%esp
     bf1:	ff 75 f0             	pushl  -0x10(%ebp)
     bf4:	e8 51 fd ff ff       	call   94a <testtimewitharg>
     bf9:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s\n", arg3[0], arg3[1]);
     bfc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bff:	83 c0 04             	add    $0x4,%eax
     c02:	8b 10                	mov    (%eax),%edx
     c04:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c07:	8b 00                	mov    (%eax),%eax
     c09:	52                   	push   %edx
     c0a:	50                   	push   %eax
     c0b:	68 29 1c 00 00       	push   $0x1c29
     c10:	6a 01                	push   $0x1
     c12:	e8 77 06 00 00       	call   128e <printf>
     c17:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg3);
     c1a:	83 ec 0c             	sub    $0xc,%esp
     c1d:	ff 75 ec             	pushl  -0x14(%ebp)
     c20:	e8 25 fd ff ff       	call   94a <testtimewitharg>
     c25:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s %s %s\n", arg4[0], arg4[1], arg4[2], arg4[3]);
     c28:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c2b:	83 c0 0c             	add    $0xc,%eax
     c2e:	8b 18                	mov    (%eax),%ebx
     c30:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c33:	83 c0 08             	add    $0x8,%eax
     c36:	8b 08                	mov    (%eax),%ecx
     c38:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c3b:	83 c0 04             	add    $0x4,%eax
     c3e:	8b 10                	mov    (%eax),%edx
     c40:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c43:	8b 00                	mov    (%eax),%eax
     c45:	83 ec 08             	sub    $0x8,%esp
     c48:	53                   	push   %ebx
     c49:	51                   	push   %ecx
     c4a:	52                   	push   %edx
     c4b:	50                   	push   %eax
     c4c:	68 31 1c 00 00       	push   $0x1c31
     c51:	6a 01                	push   $0x1
     c53:	e8 36 06 00 00       	call   128e <printf>
     c58:	83 c4 20             	add    $0x20,%esp
  testtimewitharg(arg4);
     c5b:	83 ec 0c             	sub    $0xc,%esp
     c5e:	ff 75 e8             	pushl  -0x18(%ebp)
     c61:	e8 e4 fc ff ff       	call   94a <testtimewitharg>
     c66:	83 c4 10             	add    $0x10,%esp

  free(arg1[0]);
     c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6c:	8b 00                	mov    (%eax),%eax
     c6e:	83 ec 0c             	sub    $0xc,%esp
     c71:	50                   	push   %eax
     c72:	e8 a8 07 00 00       	call   141f <free>
     c77:	83 c4 10             	add    $0x10,%esp
  free(arg1);
     c7a:	83 ec 0c             	sub    $0xc,%esp
     c7d:	ff 75 f4             	pushl  -0xc(%ebp)
     c80:	e8 9a 07 00 00       	call   141f <free>
     c85:	83 c4 10             	add    $0x10,%esp
  free(arg2[0]); free(arg2[1]);
     c88:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c8b:	8b 00                	mov    (%eax),%eax
     c8d:	83 ec 0c             	sub    $0xc,%esp
     c90:	50                   	push   %eax
     c91:	e8 89 07 00 00       	call   141f <free>
     c96:	83 c4 10             	add    $0x10,%esp
     c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c9c:	83 c0 04             	add    $0x4,%eax
     c9f:	8b 00                	mov    (%eax),%eax
     ca1:	83 ec 0c             	sub    $0xc,%esp
     ca4:	50                   	push   %eax
     ca5:	e8 75 07 00 00       	call   141f <free>
     caa:	83 c4 10             	add    $0x10,%esp
  free(arg2);
     cad:	83 ec 0c             	sub    $0xc,%esp
     cb0:	ff 75 f0             	pushl  -0x10(%ebp)
     cb3:	e8 67 07 00 00       	call   141f <free>
     cb8:	83 c4 10             	add    $0x10,%esp
  free(arg3[0]); free(arg3[1]);
     cbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cbe:	8b 00                	mov    (%eax),%eax
     cc0:	83 ec 0c             	sub    $0xc,%esp
     cc3:	50                   	push   %eax
     cc4:	e8 56 07 00 00       	call   141f <free>
     cc9:	83 c4 10             	add    $0x10,%esp
     ccc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ccf:	83 c0 04             	add    $0x4,%eax
     cd2:	8b 00                	mov    (%eax),%eax
     cd4:	83 ec 0c             	sub    $0xc,%esp
     cd7:	50                   	push   %eax
     cd8:	e8 42 07 00 00       	call   141f <free>
     cdd:	83 c4 10             	add    $0x10,%esp
  free(arg3);
     ce0:	83 ec 0c             	sub    $0xc,%esp
     ce3:	ff 75 ec             	pushl  -0x14(%ebp)
     ce6:	e8 34 07 00 00       	call   141f <free>
     ceb:	83 c4 10             	add    $0x10,%esp
  free(arg4[0]); free(arg4[1]); free(arg4[2]); free(arg4[3]);
     cee:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cf1:	8b 00                	mov    (%eax),%eax
     cf3:	83 ec 0c             	sub    $0xc,%esp
     cf6:	50                   	push   %eax
     cf7:	e8 23 07 00 00       	call   141f <free>
     cfc:	83 c4 10             	add    $0x10,%esp
     cff:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d02:	83 c0 04             	add    $0x4,%eax
     d05:	8b 00                	mov    (%eax),%eax
     d07:	83 ec 0c             	sub    $0xc,%esp
     d0a:	50                   	push   %eax
     d0b:	e8 0f 07 00 00       	call   141f <free>
     d10:	83 c4 10             	add    $0x10,%esp
     d13:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d16:	83 c0 08             	add    $0x8,%eax
     d19:	8b 00                	mov    (%eax),%eax
     d1b:	83 ec 0c             	sub    $0xc,%esp
     d1e:	50                   	push   %eax
     d1f:	e8 fb 06 00 00       	call   141f <free>
     d24:	83 c4 10             	add    $0x10,%esp
     d27:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d2a:	83 c0 0c             	add    $0xc,%eax
     d2d:	8b 00                	mov    (%eax),%eax
     d2f:	83 ec 0c             	sub    $0xc,%esp
     d32:	50                   	push   %eax
     d33:	e8 e7 06 00 00       	call   141f <free>
     d38:	83 c4 10             	add    $0x10,%esp
  free(arg4);
     d3b:	83 ec 0c             	sub    $0xc,%esp
     d3e:	ff 75 e8             	pushl  -0x18(%ebp)
     d41:	e8 d9 06 00 00       	call   141f <free>
     d46:	83 c4 10             	add    $0x10,%esp
}
     d49:	90                   	nop
     d4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d4d:	c9                   	leave  
     d4e:	c3                   	ret    

00000d4f <main>:
#endif

int
main(int argc, char *argv[])
{
     d4f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     d53:	83 e4 f0             	and    $0xfffffff0,%esp
     d56:	ff 71 fc             	pushl  -0x4(%ecx)
     d59:	55                   	push   %ebp
     d5a:	89 e5                	mov    %esp,%ebp
     d5c:	53                   	push   %ebx
     d5d:	51                   	push   %ecx
     d5e:	89 cb                	mov    %ecx,%ebx
  #ifdef CPUTIME_TEST
  testcputime(argv[0]);
     d60:	8b 43 04             	mov    0x4(%ebx),%eax
     d63:	8b 00                	mov    (%eax),%eax
     d65:	83 ec 0c             	sub    $0xc,%esp
     d68:	50                   	push   %eax
     d69:	e8 9a f7 ff ff       	call   508 <testcputime>
     d6e:	83 c4 10             	add    $0x10,%esp
  #endif
  #ifdef UIDGIDPPID_TEST
  testuidgid();
     d71:	e8 32 f4 ff ff       	call   1a8 <testuidgid>
  testuidgidinheritance();
     d76:	e8 03 f6 ff ff       	call   37e <testuidgidinheritance>
  testppid();
     d7b:	e8 80 f2 ff ff       	call   0 <testppid>
  #endif
  #ifdef GETPROCS_TEST
  testgetprocs(argv[0]);
     d80:	8b 43 04             	mov    0x4(%ebx),%eax
     d83:	8b 00                	mov    (%eax),%eax
     d85:	83 ec 0c             	sub    $0xc,%esp
     d88:	50                   	push   %eax
     d89:	e8 c4 fa ff ff       	call   852 <testgetprocs>
     d8e:	83 c4 10             	add    $0x10,%esp
  #endif
  #ifdef TIME_TEST
  testtime();
     d91:	e8 1b fc ff ff       	call   9b1 <testtime>
  #endif
  printf(1, "\n** End of Tests **\n");
     d96:	83 ec 08             	sub    $0x8,%esp
     d99:	68 3f 1c 00 00       	push   $0x1c3f
     d9e:	6a 01                	push   $0x1
     da0:	e8 e9 04 00 00       	call   128e <printf>
     da5:	83 c4 10             	add    $0x10,%esp
  exit();
     da8:	e8 2a 03 00 00       	call   10d7 <exit>

00000dad <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     dad:	55                   	push   %ebp
     dae:	89 e5                	mov    %esp,%ebp
     db0:	57                   	push   %edi
     db1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     db2:	8b 4d 08             	mov    0x8(%ebp),%ecx
     db5:	8b 55 10             	mov    0x10(%ebp),%edx
     db8:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbb:	89 cb                	mov    %ecx,%ebx
     dbd:	89 df                	mov    %ebx,%edi
     dbf:	89 d1                	mov    %edx,%ecx
     dc1:	fc                   	cld    
     dc2:	f3 aa                	rep stos %al,%es:(%edi)
     dc4:	89 ca                	mov    %ecx,%edx
     dc6:	89 fb                	mov    %edi,%ebx
     dc8:	89 5d 08             	mov    %ebx,0x8(%ebp)
     dcb:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     dce:	90                   	nop
     dcf:	5b                   	pop    %ebx
     dd0:	5f                   	pop    %edi
     dd1:	5d                   	pop    %ebp
     dd2:	c3                   	ret    

00000dd3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     dd3:	55                   	push   %ebp
     dd4:	89 e5                	mov    %esp,%ebp
     dd6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     dd9:	8b 45 08             	mov    0x8(%ebp),%eax
     ddc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     ddf:	90                   	nop
     de0:	8b 45 08             	mov    0x8(%ebp),%eax
     de3:	8d 50 01             	lea    0x1(%eax),%edx
     de6:	89 55 08             	mov    %edx,0x8(%ebp)
     de9:	8b 55 0c             	mov    0xc(%ebp),%edx
     dec:	8d 4a 01             	lea    0x1(%edx),%ecx
     def:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     df2:	0f b6 12             	movzbl (%edx),%edx
     df5:	88 10                	mov    %dl,(%eax)
     df7:	0f b6 00             	movzbl (%eax),%eax
     dfa:	84 c0                	test   %al,%al
     dfc:	75 e2                	jne    de0 <strcpy+0xd>
    ;
  return os;
     dfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e01:	c9                   	leave  
     e02:	c3                   	ret    

00000e03 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e03:	55                   	push   %ebp
     e04:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     e06:	eb 08                	jmp    e10 <strcmp+0xd>
    p++, q++;
     e08:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e0c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     e10:	8b 45 08             	mov    0x8(%ebp),%eax
     e13:	0f b6 00             	movzbl (%eax),%eax
     e16:	84 c0                	test   %al,%al
     e18:	74 10                	je     e2a <strcmp+0x27>
     e1a:	8b 45 08             	mov    0x8(%ebp),%eax
     e1d:	0f b6 10             	movzbl (%eax),%edx
     e20:	8b 45 0c             	mov    0xc(%ebp),%eax
     e23:	0f b6 00             	movzbl (%eax),%eax
     e26:	38 c2                	cmp    %al,%dl
     e28:	74 de                	je     e08 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     e2a:	8b 45 08             	mov    0x8(%ebp),%eax
     e2d:	0f b6 00             	movzbl (%eax),%eax
     e30:	0f b6 d0             	movzbl %al,%edx
     e33:	8b 45 0c             	mov    0xc(%ebp),%eax
     e36:	0f b6 00             	movzbl (%eax),%eax
     e39:	0f b6 c0             	movzbl %al,%eax
     e3c:	29 c2                	sub    %eax,%edx
     e3e:	89 d0                	mov    %edx,%eax
}
     e40:	5d                   	pop    %ebp
     e41:	c3                   	ret    

00000e42 <strlen>:

uint
strlen(char *s)
{
     e42:	55                   	push   %ebp
     e43:	89 e5                	mov    %esp,%ebp
     e45:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     e48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     e4f:	eb 04                	jmp    e55 <strlen+0x13>
     e51:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e55:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e58:	8b 45 08             	mov    0x8(%ebp),%eax
     e5b:	01 d0                	add    %edx,%eax
     e5d:	0f b6 00             	movzbl (%eax),%eax
     e60:	84 c0                	test   %al,%al
     e62:	75 ed                	jne    e51 <strlen+0xf>
    ;
  return n;
     e64:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e67:	c9                   	leave  
     e68:	c3                   	ret    

00000e69 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e69:	55                   	push   %ebp
     e6a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     e6c:	8b 45 10             	mov    0x10(%ebp),%eax
     e6f:	50                   	push   %eax
     e70:	ff 75 0c             	pushl  0xc(%ebp)
     e73:	ff 75 08             	pushl  0x8(%ebp)
     e76:	e8 32 ff ff ff       	call   dad <stosb>
     e7b:	83 c4 0c             	add    $0xc,%esp
  return dst;
     e7e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e81:	c9                   	leave  
     e82:	c3                   	ret    

00000e83 <strchr>:

char*
strchr(const char *s, char c)
{
     e83:	55                   	push   %ebp
     e84:	89 e5                	mov    %esp,%ebp
     e86:	83 ec 04             	sub    $0x4,%esp
     e89:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     e8f:	eb 14                	jmp    ea5 <strchr+0x22>
    if(*s == c)
     e91:	8b 45 08             	mov    0x8(%ebp),%eax
     e94:	0f b6 00             	movzbl (%eax),%eax
     e97:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e9a:	75 05                	jne    ea1 <strchr+0x1e>
      return (char*)s;
     e9c:	8b 45 08             	mov    0x8(%ebp),%eax
     e9f:	eb 13                	jmp    eb4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     ea1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ea5:	8b 45 08             	mov    0x8(%ebp),%eax
     ea8:	0f b6 00             	movzbl (%eax),%eax
     eab:	84 c0                	test   %al,%al
     ead:	75 e2                	jne    e91 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     eaf:	b8 00 00 00 00       	mov    $0x0,%eax
}
     eb4:	c9                   	leave  
     eb5:	c3                   	ret    

00000eb6 <gets>:

char*
gets(char *buf, int max)
{
     eb6:	55                   	push   %ebp
     eb7:	89 e5                	mov    %esp,%ebp
     eb9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ebc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ec3:	eb 42                	jmp    f07 <gets+0x51>
    cc = read(0, &c, 1);
     ec5:	83 ec 04             	sub    $0x4,%esp
     ec8:	6a 01                	push   $0x1
     eca:	8d 45 ef             	lea    -0x11(%ebp),%eax
     ecd:	50                   	push   %eax
     ece:	6a 00                	push   $0x0
     ed0:	e8 1a 02 00 00       	call   10ef <read>
     ed5:	83 c4 10             	add    $0x10,%esp
     ed8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     edb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     edf:	7e 33                	jle    f14 <gets+0x5e>
      break;
    buf[i++] = c;
     ee1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ee4:	8d 50 01             	lea    0x1(%eax),%edx
     ee7:	89 55 f4             	mov    %edx,-0xc(%ebp)
     eea:	89 c2                	mov    %eax,%edx
     eec:	8b 45 08             	mov    0x8(%ebp),%eax
     eef:	01 c2                	add    %eax,%edx
     ef1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     ef5:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     ef7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     efb:	3c 0a                	cmp    $0xa,%al
     efd:	74 16                	je     f15 <gets+0x5f>
     eff:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f03:	3c 0d                	cmp    $0xd,%al
     f05:	74 0e                	je     f15 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f0a:	83 c0 01             	add    $0x1,%eax
     f0d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f10:	7c b3                	jl     ec5 <gets+0xf>
     f12:	eb 01                	jmp    f15 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     f14:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     f15:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f18:	8b 45 08             	mov    0x8(%ebp),%eax
     f1b:	01 d0                	add    %edx,%eax
     f1d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     f20:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f23:	c9                   	leave  
     f24:	c3                   	ret    

00000f25 <stat>:

int
stat(char *n, struct stat *st)
{
     f25:	55                   	push   %ebp
     f26:	89 e5                	mov    %esp,%ebp
     f28:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f2b:	83 ec 08             	sub    $0x8,%esp
     f2e:	6a 00                	push   $0x0
     f30:	ff 75 08             	pushl  0x8(%ebp)
     f33:	e8 df 01 00 00       	call   1117 <open>
     f38:	83 c4 10             	add    $0x10,%esp
     f3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     f3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f42:	79 07                	jns    f4b <stat+0x26>
    return -1;
     f44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     f49:	eb 25                	jmp    f70 <stat+0x4b>
  r = fstat(fd, st);
     f4b:	83 ec 08             	sub    $0x8,%esp
     f4e:	ff 75 0c             	pushl  0xc(%ebp)
     f51:	ff 75 f4             	pushl  -0xc(%ebp)
     f54:	e8 d6 01 00 00       	call   112f <fstat>
     f59:	83 c4 10             	add    $0x10,%esp
     f5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     f5f:	83 ec 0c             	sub    $0xc,%esp
     f62:	ff 75 f4             	pushl  -0xc(%ebp)
     f65:	e8 95 01 00 00       	call   10ff <close>
     f6a:	83 c4 10             	add    $0x10,%esp
  return r;
     f6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     f70:	c9                   	leave  
     f71:	c3                   	ret    

00000f72 <atoi>:

int
atoi(const char *s)
{
     f72:	55                   	push   %ebp
     f73:	89 e5                	mov    %esp,%ebp
     f75:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     f78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     f7f:	eb 04                	jmp    f85 <atoi+0x13>
     f81:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f85:	8b 45 08             	mov    0x8(%ebp),%eax
     f88:	0f b6 00             	movzbl (%eax),%eax
     f8b:	3c 20                	cmp    $0x20,%al
     f8d:	74 f2                	je     f81 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
     f8f:	8b 45 08             	mov    0x8(%ebp),%eax
     f92:	0f b6 00             	movzbl (%eax),%eax
     f95:	3c 2d                	cmp    $0x2d,%al
     f97:	75 07                	jne    fa0 <atoi+0x2e>
     f99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     f9e:	eb 05                	jmp    fa5 <atoi+0x33>
     fa0:	b8 01 00 00 00       	mov    $0x1,%eax
     fa5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     fa8:	8b 45 08             	mov    0x8(%ebp),%eax
     fab:	0f b6 00             	movzbl (%eax),%eax
     fae:	3c 2b                	cmp    $0x2b,%al
     fb0:	74 0a                	je     fbc <atoi+0x4a>
     fb2:	8b 45 08             	mov    0x8(%ebp),%eax
     fb5:	0f b6 00             	movzbl (%eax),%eax
     fb8:	3c 2d                	cmp    $0x2d,%al
     fba:	75 2b                	jne    fe7 <atoi+0x75>
    s++;
     fbc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     fc0:	eb 25                	jmp    fe7 <atoi+0x75>
    n = n*10 + *s++ - '0';
     fc2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     fc5:	89 d0                	mov    %edx,%eax
     fc7:	c1 e0 02             	shl    $0x2,%eax
     fca:	01 d0                	add    %edx,%eax
     fcc:	01 c0                	add    %eax,%eax
     fce:	89 c1                	mov    %eax,%ecx
     fd0:	8b 45 08             	mov    0x8(%ebp),%eax
     fd3:	8d 50 01             	lea    0x1(%eax),%edx
     fd6:	89 55 08             	mov    %edx,0x8(%ebp)
     fd9:	0f b6 00             	movzbl (%eax),%eax
     fdc:	0f be c0             	movsbl %al,%eax
     fdf:	01 c8                	add    %ecx,%eax
     fe1:	83 e8 30             	sub    $0x30,%eax
     fe4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
     fe7:	8b 45 08             	mov    0x8(%ebp),%eax
     fea:	0f b6 00             	movzbl (%eax),%eax
     fed:	3c 2f                	cmp    $0x2f,%al
     fef:	7e 0a                	jle    ffb <atoi+0x89>
     ff1:	8b 45 08             	mov    0x8(%ebp),%eax
     ff4:	0f b6 00             	movzbl (%eax),%eax
     ff7:	3c 39                	cmp    $0x39,%al
     ff9:	7e c7                	jle    fc2 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
     ffb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ffe:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
    1002:	c9                   	leave  
    1003:	c3                   	ret    

00001004 <atoo>:

int
atoo(const char *s)
{
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
    100a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
    1011:	eb 04                	jmp    1017 <atoo+0x13>
    1013:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1017:	8b 45 08             	mov    0x8(%ebp),%eax
    101a:	0f b6 00             	movzbl (%eax),%eax
    101d:	3c 20                	cmp    $0x20,%al
    101f:	74 f2                	je     1013 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
    1021:	8b 45 08             	mov    0x8(%ebp),%eax
    1024:	0f b6 00             	movzbl (%eax),%eax
    1027:	3c 2d                	cmp    $0x2d,%al
    1029:	75 07                	jne    1032 <atoo+0x2e>
    102b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1030:	eb 05                	jmp    1037 <atoo+0x33>
    1032:	b8 01 00 00 00       	mov    $0x1,%eax
    1037:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
    103a:	8b 45 08             	mov    0x8(%ebp),%eax
    103d:	0f b6 00             	movzbl (%eax),%eax
    1040:	3c 2b                	cmp    $0x2b,%al
    1042:	74 0a                	je     104e <atoo+0x4a>
    1044:	8b 45 08             	mov    0x8(%ebp),%eax
    1047:	0f b6 00             	movzbl (%eax),%eax
    104a:	3c 2d                	cmp    $0x2d,%al
    104c:	75 27                	jne    1075 <atoo+0x71>
    s++;
    104e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
    1052:	eb 21                	jmp    1075 <atoo+0x71>
    n = n*8 + *s++ - '0';
    1054:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1057:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
    105e:	8b 45 08             	mov    0x8(%ebp),%eax
    1061:	8d 50 01             	lea    0x1(%eax),%edx
    1064:	89 55 08             	mov    %edx,0x8(%ebp)
    1067:	0f b6 00             	movzbl (%eax),%eax
    106a:	0f be c0             	movsbl %al,%eax
    106d:	01 c8                	add    %ecx,%eax
    106f:	83 e8 30             	sub    $0x30,%eax
    1072:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
    1075:	8b 45 08             	mov    0x8(%ebp),%eax
    1078:	0f b6 00             	movzbl (%eax),%eax
    107b:	3c 2f                	cmp    $0x2f,%al
    107d:	7e 0a                	jle    1089 <atoo+0x85>
    107f:	8b 45 08             	mov    0x8(%ebp),%eax
    1082:	0f b6 00             	movzbl (%eax),%eax
    1085:	3c 37                	cmp    $0x37,%al
    1087:	7e cb                	jle    1054 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
    1089:	8b 45 f8             	mov    -0x8(%ebp),%eax
    108c:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
    1090:	c9                   	leave  
    1091:	c3                   	ret    

00001092 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
    1092:	55                   	push   %ebp
    1093:	89 e5                	mov    %esp,%ebp
    1095:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1098:	8b 45 08             	mov    0x8(%ebp),%eax
    109b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    109e:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    10a4:	eb 17                	jmp    10bd <memmove+0x2b>
    *dst++ = *src++;
    10a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10a9:	8d 50 01             	lea    0x1(%eax),%edx
    10ac:	89 55 fc             	mov    %edx,-0x4(%ebp)
    10af:	8b 55 f8             	mov    -0x8(%ebp),%edx
    10b2:	8d 4a 01             	lea    0x1(%edx),%ecx
    10b5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    10b8:	0f b6 12             	movzbl (%edx),%edx
    10bb:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    10bd:	8b 45 10             	mov    0x10(%ebp),%eax
    10c0:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c3:	89 55 10             	mov    %edx,0x10(%ebp)
    10c6:	85 c0                	test   %eax,%eax
    10c8:	7f dc                	jg     10a6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
}
    10cd:	c9                   	leave  
    10ce:	c3                   	ret    

000010cf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    10cf:	b8 01 00 00 00       	mov    $0x1,%eax
    10d4:	cd 40                	int    $0x40
    10d6:	c3                   	ret    

000010d7 <exit>:
SYSCALL(exit)
    10d7:	b8 02 00 00 00       	mov    $0x2,%eax
    10dc:	cd 40                	int    $0x40
    10de:	c3                   	ret    

000010df <wait>:
SYSCALL(wait)
    10df:	b8 03 00 00 00       	mov    $0x3,%eax
    10e4:	cd 40                	int    $0x40
    10e6:	c3                   	ret    

000010e7 <pipe>:
SYSCALL(pipe)
    10e7:	b8 04 00 00 00       	mov    $0x4,%eax
    10ec:	cd 40                	int    $0x40
    10ee:	c3                   	ret    

000010ef <read>:
SYSCALL(read)
    10ef:	b8 05 00 00 00       	mov    $0x5,%eax
    10f4:	cd 40                	int    $0x40
    10f6:	c3                   	ret    

000010f7 <write>:
SYSCALL(write)
    10f7:	b8 10 00 00 00       	mov    $0x10,%eax
    10fc:	cd 40                	int    $0x40
    10fe:	c3                   	ret    

000010ff <close>:
SYSCALL(close)
    10ff:	b8 15 00 00 00       	mov    $0x15,%eax
    1104:	cd 40                	int    $0x40
    1106:	c3                   	ret    

00001107 <kill>:
SYSCALL(kill)
    1107:	b8 06 00 00 00       	mov    $0x6,%eax
    110c:	cd 40                	int    $0x40
    110e:	c3                   	ret    

0000110f <exec>:
SYSCALL(exec)
    110f:	b8 07 00 00 00       	mov    $0x7,%eax
    1114:	cd 40                	int    $0x40
    1116:	c3                   	ret    

00001117 <open>:
SYSCALL(open)
    1117:	b8 0f 00 00 00       	mov    $0xf,%eax
    111c:	cd 40                	int    $0x40
    111e:	c3                   	ret    

0000111f <mknod>:
SYSCALL(mknod)
    111f:	b8 11 00 00 00       	mov    $0x11,%eax
    1124:	cd 40                	int    $0x40
    1126:	c3                   	ret    

00001127 <unlink>:
SYSCALL(unlink)
    1127:	b8 12 00 00 00       	mov    $0x12,%eax
    112c:	cd 40                	int    $0x40
    112e:	c3                   	ret    

0000112f <fstat>:
SYSCALL(fstat)
    112f:	b8 08 00 00 00       	mov    $0x8,%eax
    1134:	cd 40                	int    $0x40
    1136:	c3                   	ret    

00001137 <link>:
SYSCALL(link)
    1137:	b8 13 00 00 00       	mov    $0x13,%eax
    113c:	cd 40                	int    $0x40
    113e:	c3                   	ret    

0000113f <mkdir>:
SYSCALL(mkdir)
    113f:	b8 14 00 00 00       	mov    $0x14,%eax
    1144:	cd 40                	int    $0x40
    1146:	c3                   	ret    

00001147 <chdir>:
SYSCALL(chdir)
    1147:	b8 09 00 00 00       	mov    $0x9,%eax
    114c:	cd 40                	int    $0x40
    114e:	c3                   	ret    

0000114f <dup>:
SYSCALL(dup)
    114f:	b8 0a 00 00 00       	mov    $0xa,%eax
    1154:	cd 40                	int    $0x40
    1156:	c3                   	ret    

00001157 <getpid>:
SYSCALL(getpid)
    1157:	b8 0b 00 00 00       	mov    $0xb,%eax
    115c:	cd 40                	int    $0x40
    115e:	c3                   	ret    

0000115f <sbrk>:
SYSCALL(sbrk)
    115f:	b8 0c 00 00 00       	mov    $0xc,%eax
    1164:	cd 40                	int    $0x40
    1166:	c3                   	ret    

00001167 <sleep>:
SYSCALL(sleep)
    1167:	b8 0d 00 00 00       	mov    $0xd,%eax
    116c:	cd 40                	int    $0x40
    116e:	c3                   	ret    

0000116f <uptime>:
SYSCALL(uptime)
    116f:	b8 0e 00 00 00       	mov    $0xe,%eax
    1174:	cd 40                	int    $0x40
    1176:	c3                   	ret    

00001177 <halt>:
SYSCALL(halt)
    1177:	b8 16 00 00 00       	mov    $0x16,%eax
    117c:	cd 40                	int    $0x40
    117e:	c3                   	ret    

0000117f <date>:
SYSCALL(date)
    117f:	b8 17 00 00 00       	mov    $0x17,%eax
    1184:	cd 40                	int    $0x40
    1186:	c3                   	ret    

00001187 <getuid>:
SYSCALL(getuid)
    1187:	b8 18 00 00 00       	mov    $0x18,%eax
    118c:	cd 40                	int    $0x40
    118e:	c3                   	ret    

0000118f <getgid>:
SYSCALL(getgid)
    118f:	b8 19 00 00 00       	mov    $0x19,%eax
    1194:	cd 40                	int    $0x40
    1196:	c3                   	ret    

00001197 <getppid>:
SYSCALL(getppid)
    1197:	b8 1a 00 00 00       	mov    $0x1a,%eax
    119c:	cd 40                	int    $0x40
    119e:	c3                   	ret    

0000119f <setuid>:
SYSCALL(setuid)
    119f:	b8 1b 00 00 00       	mov    $0x1b,%eax
    11a4:	cd 40                	int    $0x40
    11a6:	c3                   	ret    

000011a7 <setgid>:
SYSCALL(setgid)
    11a7:	b8 1c 00 00 00       	mov    $0x1c,%eax
    11ac:	cd 40                	int    $0x40
    11ae:	c3                   	ret    

000011af <getprocs>:
SYSCALL(getprocs)
    11af:	b8 1d 00 00 00       	mov    $0x1d,%eax
    11b4:	cd 40                	int    $0x40
    11b6:	c3                   	ret    

000011b7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    11b7:	55                   	push   %ebp
    11b8:	89 e5                	mov    %esp,%ebp
    11ba:	83 ec 18             	sub    $0x18,%esp
    11bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    11c3:	83 ec 04             	sub    $0x4,%esp
    11c6:	6a 01                	push   $0x1
    11c8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    11cb:	50                   	push   %eax
    11cc:	ff 75 08             	pushl  0x8(%ebp)
    11cf:	e8 23 ff ff ff       	call   10f7 <write>
    11d4:	83 c4 10             	add    $0x10,%esp
}
    11d7:	90                   	nop
    11d8:	c9                   	leave  
    11d9:	c3                   	ret    

000011da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    11da:	55                   	push   %ebp
    11db:	89 e5                	mov    %esp,%ebp
    11dd:	53                   	push   %ebx
    11de:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    11e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    11e8:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    11ec:	74 17                	je     1205 <printint+0x2b>
    11ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11f2:	79 11                	jns    1205 <printint+0x2b>
    neg = 1;
    11f4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    11fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fe:	f7 d8                	neg    %eax
    1200:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1203:	eb 06                	jmp    120b <printint+0x31>
  } else {
    x = xx;
    1205:	8b 45 0c             	mov    0xc(%ebp),%eax
    1208:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    120b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1212:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1215:	8d 41 01             	lea    0x1(%ecx),%eax
    1218:	89 45 f4             	mov    %eax,-0xc(%ebp)
    121b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    121e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1221:	ba 00 00 00 00       	mov    $0x0,%edx
    1226:	f7 f3                	div    %ebx
    1228:	89 d0                	mov    %edx,%eax
    122a:	0f b6 80 4c 20 00 00 	movzbl 0x204c(%eax),%eax
    1231:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1235:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1238:	8b 45 ec             	mov    -0x14(%ebp),%eax
    123b:	ba 00 00 00 00       	mov    $0x0,%edx
    1240:	f7 f3                	div    %ebx
    1242:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1245:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1249:	75 c7                	jne    1212 <printint+0x38>
  if(neg)
    124b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    124f:	74 2d                	je     127e <printint+0xa4>
    buf[i++] = '-';
    1251:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1254:	8d 50 01             	lea    0x1(%eax),%edx
    1257:	89 55 f4             	mov    %edx,-0xc(%ebp)
    125a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    125f:	eb 1d                	jmp    127e <printint+0xa4>
    putc(fd, buf[i]);
    1261:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1264:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1267:	01 d0                	add    %edx,%eax
    1269:	0f b6 00             	movzbl (%eax),%eax
    126c:	0f be c0             	movsbl %al,%eax
    126f:	83 ec 08             	sub    $0x8,%esp
    1272:	50                   	push   %eax
    1273:	ff 75 08             	pushl  0x8(%ebp)
    1276:	e8 3c ff ff ff       	call   11b7 <putc>
    127b:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    127e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1282:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1286:	79 d9                	jns    1261 <printint+0x87>
    putc(fd, buf[i]);
}
    1288:	90                   	nop
    1289:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    128c:	c9                   	leave  
    128d:	c3                   	ret    

0000128e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    128e:	55                   	push   %ebp
    128f:	89 e5                	mov    %esp,%ebp
    1291:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1294:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    129b:	8d 45 0c             	lea    0xc(%ebp),%eax
    129e:	83 c0 04             	add    $0x4,%eax
    12a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    12a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12ab:	e9 59 01 00 00       	jmp    1409 <printf+0x17b>
    c = fmt[i] & 0xff;
    12b0:	8b 55 0c             	mov    0xc(%ebp),%edx
    12b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12b6:	01 d0                	add    %edx,%eax
    12b8:	0f b6 00             	movzbl (%eax),%eax
    12bb:	0f be c0             	movsbl %al,%eax
    12be:	25 ff 00 00 00       	and    $0xff,%eax
    12c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    12c6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12ca:	75 2c                	jne    12f8 <printf+0x6a>
      if(c == '%'){
    12cc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    12d0:	75 0c                	jne    12de <printf+0x50>
        state = '%';
    12d2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    12d9:	e9 27 01 00 00       	jmp    1405 <printf+0x177>
      } else {
        putc(fd, c);
    12de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12e1:	0f be c0             	movsbl %al,%eax
    12e4:	83 ec 08             	sub    $0x8,%esp
    12e7:	50                   	push   %eax
    12e8:	ff 75 08             	pushl  0x8(%ebp)
    12eb:	e8 c7 fe ff ff       	call   11b7 <putc>
    12f0:	83 c4 10             	add    $0x10,%esp
    12f3:	e9 0d 01 00 00       	jmp    1405 <printf+0x177>
      }
    } else if(state == '%'){
    12f8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    12fc:	0f 85 03 01 00 00    	jne    1405 <printf+0x177>
      if(c == 'd'){
    1302:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1306:	75 1e                	jne    1326 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1308:	8b 45 e8             	mov    -0x18(%ebp),%eax
    130b:	8b 00                	mov    (%eax),%eax
    130d:	6a 01                	push   $0x1
    130f:	6a 0a                	push   $0xa
    1311:	50                   	push   %eax
    1312:	ff 75 08             	pushl  0x8(%ebp)
    1315:	e8 c0 fe ff ff       	call   11da <printint>
    131a:	83 c4 10             	add    $0x10,%esp
        ap++;
    131d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1321:	e9 d8 00 00 00       	jmp    13fe <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1326:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    132a:	74 06                	je     1332 <printf+0xa4>
    132c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1330:	75 1e                	jne    1350 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1332:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1335:	8b 00                	mov    (%eax),%eax
    1337:	6a 00                	push   $0x0
    1339:	6a 10                	push   $0x10
    133b:	50                   	push   %eax
    133c:	ff 75 08             	pushl  0x8(%ebp)
    133f:	e8 96 fe ff ff       	call   11da <printint>
    1344:	83 c4 10             	add    $0x10,%esp
        ap++;
    1347:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    134b:	e9 ae 00 00 00       	jmp    13fe <printf+0x170>
      } else if(c == 's'){
    1350:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1354:	75 43                	jne    1399 <printf+0x10b>
        s = (char*)*ap;
    1356:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1359:	8b 00                	mov    (%eax),%eax
    135b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    135e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1362:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1366:	75 25                	jne    138d <printf+0xff>
          s = "(null)";
    1368:	c7 45 f4 54 1c 00 00 	movl   $0x1c54,-0xc(%ebp)
        while(*s != 0){
    136f:	eb 1c                	jmp    138d <printf+0xff>
          putc(fd, *s);
    1371:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1374:	0f b6 00             	movzbl (%eax),%eax
    1377:	0f be c0             	movsbl %al,%eax
    137a:	83 ec 08             	sub    $0x8,%esp
    137d:	50                   	push   %eax
    137e:	ff 75 08             	pushl  0x8(%ebp)
    1381:	e8 31 fe ff ff       	call   11b7 <putc>
    1386:	83 c4 10             	add    $0x10,%esp
          s++;
    1389:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    138d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1390:	0f b6 00             	movzbl (%eax),%eax
    1393:	84 c0                	test   %al,%al
    1395:	75 da                	jne    1371 <printf+0xe3>
    1397:	eb 65                	jmp    13fe <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1399:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    139d:	75 1d                	jne    13bc <printf+0x12e>
        putc(fd, *ap);
    139f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13a2:	8b 00                	mov    (%eax),%eax
    13a4:	0f be c0             	movsbl %al,%eax
    13a7:	83 ec 08             	sub    $0x8,%esp
    13aa:	50                   	push   %eax
    13ab:	ff 75 08             	pushl  0x8(%ebp)
    13ae:	e8 04 fe ff ff       	call   11b7 <putc>
    13b3:	83 c4 10             	add    $0x10,%esp
        ap++;
    13b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    13ba:	eb 42                	jmp    13fe <printf+0x170>
      } else if(c == '%'){
    13bc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    13c0:	75 17                	jne    13d9 <printf+0x14b>
        putc(fd, c);
    13c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13c5:	0f be c0             	movsbl %al,%eax
    13c8:	83 ec 08             	sub    $0x8,%esp
    13cb:	50                   	push   %eax
    13cc:	ff 75 08             	pushl  0x8(%ebp)
    13cf:	e8 e3 fd ff ff       	call   11b7 <putc>
    13d4:	83 c4 10             	add    $0x10,%esp
    13d7:	eb 25                	jmp    13fe <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    13d9:	83 ec 08             	sub    $0x8,%esp
    13dc:	6a 25                	push   $0x25
    13de:	ff 75 08             	pushl  0x8(%ebp)
    13e1:	e8 d1 fd ff ff       	call   11b7 <putc>
    13e6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    13e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13ec:	0f be c0             	movsbl %al,%eax
    13ef:	83 ec 08             	sub    $0x8,%esp
    13f2:	50                   	push   %eax
    13f3:	ff 75 08             	pushl  0x8(%ebp)
    13f6:	e8 bc fd ff ff       	call   11b7 <putc>
    13fb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    13fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1405:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1409:	8b 55 0c             	mov    0xc(%ebp),%edx
    140c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    140f:	01 d0                	add    %edx,%eax
    1411:	0f b6 00             	movzbl (%eax),%eax
    1414:	84 c0                	test   %al,%al
    1416:	0f 85 94 fe ff ff    	jne    12b0 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    141c:	90                   	nop
    141d:	c9                   	leave  
    141e:	c3                   	ret    

0000141f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    141f:	55                   	push   %ebp
    1420:	89 e5                	mov    %esp,%ebp
    1422:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1425:	8b 45 08             	mov    0x8(%ebp),%eax
    1428:	83 e8 08             	sub    $0x8,%eax
    142b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    142e:	a1 68 20 00 00       	mov    0x2068,%eax
    1433:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1436:	eb 24                	jmp    145c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1438:	8b 45 fc             	mov    -0x4(%ebp),%eax
    143b:	8b 00                	mov    (%eax),%eax
    143d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1440:	77 12                	ja     1454 <free+0x35>
    1442:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1445:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1448:	77 24                	ja     146e <free+0x4f>
    144a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    144d:	8b 00                	mov    (%eax),%eax
    144f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1452:	77 1a                	ja     146e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1454:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1457:	8b 00                	mov    (%eax),%eax
    1459:	89 45 fc             	mov    %eax,-0x4(%ebp)
    145c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    145f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1462:	76 d4                	jbe    1438 <free+0x19>
    1464:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1467:	8b 00                	mov    (%eax),%eax
    1469:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    146c:	76 ca                	jbe    1438 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    146e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1471:	8b 40 04             	mov    0x4(%eax),%eax
    1474:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    147b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    147e:	01 c2                	add    %eax,%edx
    1480:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1483:	8b 00                	mov    (%eax),%eax
    1485:	39 c2                	cmp    %eax,%edx
    1487:	75 24                	jne    14ad <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1489:	8b 45 f8             	mov    -0x8(%ebp),%eax
    148c:	8b 50 04             	mov    0x4(%eax),%edx
    148f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1492:	8b 00                	mov    (%eax),%eax
    1494:	8b 40 04             	mov    0x4(%eax),%eax
    1497:	01 c2                	add    %eax,%edx
    1499:	8b 45 f8             	mov    -0x8(%ebp),%eax
    149c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    149f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14a2:	8b 00                	mov    (%eax),%eax
    14a4:	8b 10                	mov    (%eax),%edx
    14a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14a9:	89 10                	mov    %edx,(%eax)
    14ab:	eb 0a                	jmp    14b7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    14ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14b0:	8b 10                	mov    (%eax),%edx
    14b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14b5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    14b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14ba:	8b 40 04             	mov    0x4(%eax),%eax
    14bd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    14c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14c7:	01 d0                	add    %edx,%eax
    14c9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14cc:	75 20                	jne    14ee <free+0xcf>
    p->s.size += bp->s.size;
    14ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14d1:	8b 50 04             	mov    0x4(%eax),%edx
    14d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14d7:	8b 40 04             	mov    0x4(%eax),%eax
    14da:	01 c2                	add    %eax,%edx
    14dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    14e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14e5:	8b 10                	mov    (%eax),%edx
    14e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14ea:	89 10                	mov    %edx,(%eax)
    14ec:	eb 08                	jmp    14f6 <free+0xd7>
  } else
    p->s.ptr = bp;
    14ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
    14f4:	89 10                	mov    %edx,(%eax)
  freep = p;
    14f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14f9:	a3 68 20 00 00       	mov    %eax,0x2068
}
    14fe:	90                   	nop
    14ff:	c9                   	leave  
    1500:	c3                   	ret    

00001501 <morecore>:

static Header*
morecore(uint nu)
{
    1501:	55                   	push   %ebp
    1502:	89 e5                	mov    %esp,%ebp
    1504:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1507:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    150e:	77 07                	ja     1517 <morecore+0x16>
    nu = 4096;
    1510:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1517:	8b 45 08             	mov    0x8(%ebp),%eax
    151a:	c1 e0 03             	shl    $0x3,%eax
    151d:	83 ec 0c             	sub    $0xc,%esp
    1520:	50                   	push   %eax
    1521:	e8 39 fc ff ff       	call   115f <sbrk>
    1526:	83 c4 10             	add    $0x10,%esp
    1529:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    152c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1530:	75 07                	jne    1539 <morecore+0x38>
    return 0;
    1532:	b8 00 00 00 00       	mov    $0x0,%eax
    1537:	eb 26                	jmp    155f <morecore+0x5e>
  hp = (Header*)p;
    1539:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    153f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1542:	8b 55 08             	mov    0x8(%ebp),%edx
    1545:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1548:	8b 45 f0             	mov    -0x10(%ebp),%eax
    154b:	83 c0 08             	add    $0x8,%eax
    154e:	83 ec 0c             	sub    $0xc,%esp
    1551:	50                   	push   %eax
    1552:	e8 c8 fe ff ff       	call   141f <free>
    1557:	83 c4 10             	add    $0x10,%esp
  return freep;
    155a:	a1 68 20 00 00       	mov    0x2068,%eax
}
    155f:	c9                   	leave  
    1560:	c3                   	ret    

00001561 <malloc>:

void*
malloc(uint nbytes)
{
    1561:	55                   	push   %ebp
    1562:	89 e5                	mov    %esp,%ebp
    1564:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1567:	8b 45 08             	mov    0x8(%ebp),%eax
    156a:	83 c0 07             	add    $0x7,%eax
    156d:	c1 e8 03             	shr    $0x3,%eax
    1570:	83 c0 01             	add    $0x1,%eax
    1573:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1576:	a1 68 20 00 00       	mov    0x2068,%eax
    157b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    157e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1582:	75 23                	jne    15a7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1584:	c7 45 f0 60 20 00 00 	movl   $0x2060,-0x10(%ebp)
    158b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    158e:	a3 68 20 00 00       	mov    %eax,0x2068
    1593:	a1 68 20 00 00       	mov    0x2068,%eax
    1598:	a3 60 20 00 00       	mov    %eax,0x2060
    base.s.size = 0;
    159d:	c7 05 64 20 00 00 00 	movl   $0x0,0x2064
    15a4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15aa:	8b 00                	mov    (%eax),%eax
    15ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    15af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b2:	8b 40 04             	mov    0x4(%eax),%eax
    15b5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    15b8:	72 4d                	jb     1607 <malloc+0xa6>
      if(p->s.size == nunits)
    15ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bd:	8b 40 04             	mov    0x4(%eax),%eax
    15c0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    15c3:	75 0c                	jne    15d1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    15c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c8:	8b 10                	mov    (%eax),%edx
    15ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15cd:	89 10                	mov    %edx,(%eax)
    15cf:	eb 26                	jmp    15f7 <malloc+0x96>
      else {
        p->s.size -= nunits;
    15d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d4:	8b 40 04             	mov    0x4(%eax),%eax
    15d7:	2b 45 ec             	sub    -0x14(%ebp),%eax
    15da:	89 c2                	mov    %eax,%edx
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 04             	mov    0x4(%eax),%eax
    15e8:	c1 e0 03             	shl    $0x3,%eax
    15eb:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    15ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    15f4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    15f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15fa:	a3 68 20 00 00       	mov    %eax,0x2068
      return (void*)(p + 1);
    15ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1602:	83 c0 08             	add    $0x8,%eax
    1605:	eb 3b                	jmp    1642 <malloc+0xe1>
    }
    if(p == freep)
    1607:	a1 68 20 00 00       	mov    0x2068,%eax
    160c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    160f:	75 1e                	jne    162f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1611:	83 ec 0c             	sub    $0xc,%esp
    1614:	ff 75 ec             	pushl  -0x14(%ebp)
    1617:	e8 e5 fe ff ff       	call   1501 <morecore>
    161c:	83 c4 10             	add    $0x10,%esp
    161f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1622:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1626:	75 07                	jne    162f <malloc+0xce>
        return 0;
    1628:	b8 00 00 00 00       	mov    $0x0,%eax
    162d:	eb 13                	jmp    1642 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    162f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1632:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	8b 00                	mov    (%eax),%eax
    163a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    163d:	e9 6d ff ff ff       	jmp    15af <malloc+0x4e>
}
    1642:	c9                   	leave  
    1643:	c3                   	ret    
