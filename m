Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DCD2F0
	for <linux-x25@vger.kernel.org>; Sun, 25 Feb 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708846085; cv=none; b=uVnDnOW14eyVkJmgS/KM8XHFVpnldcC10uyvqaoo9d35TT0snv2RKImWMSsJI9UxBSj5W7Q80aaxwevtg81TBZmgwoiKGrRQ5cv9T3ZX935V18Wq1hAj+UaFf9KDDQiQoeYWXfjZL3Q9jjk8Zo5OaXh9v6YvLC//Vk+KTZHNLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708846085; c=relaxed/simple;
	bh=unoUZHnNLWo85kVwRNGfukzNpxB9UQvc6x3BLRWDZdI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hX2I3fP2pUB7exXtahiEjnjUx2uXvrjXFuwTFvuBYphSLzJ/T18aOtgZC/umKeDBcuajG9nzmB/84qoUad8SO7OOcruJ0A7+qjwXntbr23wdvnTq9XuAr/GLQXpuC/U5B2dGDtTpFUwnQC11O7mrnwDvFlSCgFAXB+n3pJ2uT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3657dff68d6so23144545ab.0
        for <linux-x25@vger.kernel.org>; Sat, 24 Feb 2024 23:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708846083; x=1709450883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzsFQMYU8YtNGOBZjM6fd0mO1h4UtTBUtieIA5+iT0w=;
        b=eQ57MkS6GBBwRUs8ASvcB4Sdmfr7/zyI7guaYXM6P80llmyFMO2VpRqHt+a/5SVNe3
         yDePO4/KQV/Q63g3GKLjJE6ZVUGK37zdU9bIPyldyNL5zO7eoa2v+rhC3R+mO5Bq1qsf
         UZDCjMW3Gq2WHTN6tIbtrvwnnduWW6eTk7GA1nnltdbxDdbTlmTD5+q9MODGXEbDYUn4
         7VFMCpCa3mF8PQAR9LzHtGzLVhfXGmi+d/2CllzaDm5aUsil2EuBnZacV8DCfM+Eho7R
         5YArqXf2S7SJnl9dZDRvpop6n40Tlg3LxYt6kuRo9XYTbC6i8wwSkIPAptRsPYh8NQyk
         BXFw==
X-Forwarded-Encrypted: i=1; AJvYcCU0MBZ6lY09COEHo7vC3PlnzAotS4TISz9kKg0Ger/TYnVdUi9gTkocwlOXY4o4FuwugPQ/GVQ3jJm/PwLx9psQHTCfOW/me+HK
X-Gm-Message-State: AOJu0YwTysD+2jxoA3qVoZpkdaXTXcAJ9ts8x3m055vRHu/auwJcUmkc
	nOAPaOPemuZCidl8NSyLKHgH90WQDTzmoGaZF5W1WxjOWqL8ytDyNK/QACJjjqSGBrQMiIgTbgg
	Dp2SDyvql5P1QQeyZx7QpuYois7m19dpcqZWfcDwRSUInsRWI6ZS56Ds=
X-Google-Smtp-Source: AGHT+IHMzsSTbqyGkWMdz6rESKzE7k0hvpJkoDrMjtx+4rAEl5iPtoYZeEnv9sgMQieN4CN0vwu7qeu/Lc7SMTpoBQs9YEgIvxul
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:365:4d61:fe6 with SMTP id
 i10-20020a056e021d0a00b003654d610fe6mr251453ila.1.1708846082942; Sat, 24 Feb
 2024 23:28:02 -0800 (PST)
Date: Sat, 24 Feb 2024 23:28:02 -0800
In-Reply-To: <0000000000006c9d500608b2c62b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfed0206122fbb7c@google.com>
Subject: Re: [syzbot] [x25?] [reiserfs?] general protection fault in lapbeth_data_transmit
From: syzbot <syzbot+6062afbf92a14f75d88b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, davem@davemloft.net, 
	edumazet@google.com, jack@suse.cz, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12dcaac4180000
start commit:   1b29d271614a Merge tag 'staging-6.4-rc7' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=6062afbf92a14f75d88b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150a0f73280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107fcaff280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
