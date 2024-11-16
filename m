Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732916D4E6
	for <linux-x25@vger.kernel.org>; Sat, 16 Nov 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771661; cv=none; b=JuJW8ZqCwJ8lAwm8eZuQeczo5i1noUIsS7BZx6d2gxcVmpN4q9os3vqe5s+kDgjjILo/b0PiLfYG4Sp8PZ8VxVAt40RrNCe06SEXShM50BpEqw05ETYwr5AyWC6lAyJyFPzH1JiXFAGRImJxQIGFzpAqUc9gfrm//KSjqU3GQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771661; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=IHgLiJlTdS6WnMfvxLGNwHKg4kCoODWFkzv6hwLixK+xs3WO9LOjH+eNBBXT28mx2kZHryDSQhADPeYhnD7DqYLuSgdFrm9Fn2fIptKJfWX+/v7yI5q8CRzkUsVWfQYaO7q0TPD90J59a8qCF6Fn5Ii3dHvF91+bI3m/p/CTTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7QJOoG7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7QJOoG7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdda5cfb6so15795845ad.3
        for <linux-x25@vger.kernel.org>; Sat, 16 Nov 2024 07:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771659; x=1732376459; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=J7QJOoG7sqEXokfMVGSIR82urNuHbs8nLwyBct4dvRXBSOomRcs7HWVMO9sj44PSOf
         QbXu/GguLTX6kwUwC52qpXIhkvYgjBmF/m8e+WqDhtBsCldvdUxPAYsq+SaRUQPV6AlI
         oF50brD5QpwUzofjndh63FVxGexyJ32k2cIuiyVJaIC0HHrkGOqguDSvoB9Ux3K4Cqh9
         Uwh+5PH4FRWRl+AHbb7LTjLdkFSWQMBP1DbKeD1MQmaKuNbuGttO1ykmaA9DJVTyarSn
         b6kp5ZRK/l2f6KkuxdBBc4QhSJTqAx3q1AcQmqXVNj8lFn7VRXaUmz8gx6e666g+V0wx
         R/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771659; x=1732376459;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=Iz1QKqIIsvwP31ct7aUg6q7CZtY+LsEHL9ZfBgzeW+jee+b4Yimjy/eWExd277ftDJ
         4qHhjEz+1aIPBnlEJyYsGXN8mOiTmBzhWhkMkc478RtA6Y4RTil7zenrlnPmlpWvH9vw
         8E0OYNu33GtbDdPXNtp8hPpYgkjbNs+vILes81mXdhOWvL0lE3UGmP4TXo1SUjkfDBSJ
         ugs63/ObCG4IsAI/XYdm5eCb4tVoG761xW0sRAUQwCZQe1zJnfzSRauR+VS0epVq4V4f
         poqtKOTuUG5jFQsbnlO9lNxd3WOCB9i+/hAPMsI6nyesltNGpBfUd+zEPoyTeGcEJe7Y
         wS+Q==
X-Gm-Message-State: AOJu0YwBL5JDr7VzQK4fxfbf1Xm5S6jtaj+AseRbuiT2WJ9siwua2E2+
	RCDaYGbGEIhMYxPRYC4GxQL9pd3rwxcDGkY5fPCnDyKInNrB+zGBdhhbMw==
X-Google-Smtp-Source: AGHT+IG5lrgAxIwmrmmcYdU9iXCzTDXYgjCl3xlQOQwf78AKi0E14+io9Cf+i3t185hCPNefrR4C1A==
X-Received: by 2002:a17:903:2d1:b0:20b:9547:9b36 with SMTP id d9443c01a7336-211d0ec8f17mr94998385ad.46.1731771659215;
        Sat, 16 Nov 2024 07:40:59 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc322fsm29097845ad.19.2024.11.16.07.40.58
        for <linux-x25@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:58 -0800 (PST)
From: "Van. HR" <fallelhadj31@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <efe25f9f6962056f1dae439ee02f63bc6a0d8367213708336646e20567d70d61@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-x25@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:56 -0500
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

