FROM ubuntu

RUN apt update && apt install -y \
    openssh-server \
    sudo \
    coreutils \
    grep \
    findutils \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m darkarmy0 && echo "darkarmy0:darkarmy0" | chpasswd && adduser darkarmy0 sudo
RUN useradd -m darkarmy1 && echo "darkarmy1:darkarmy1" | chpasswd && adduser darkarmy1 sudo
RUN useradd -m darkarmy2 && echo "darkarmy2:darkarmy2" | chpasswd && adduser darkarmy2 sudo
RUN useradd -m darkarmy3 && echo "darkarmy3:darkarmy3" | chpasswd && adduser darkarmy3 sudo

RUN mkdir /var/run/sshd
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Trying to remove the annoying message when ssh into the server
RUN touch /home/darkarmy0/.hushlogin
RUN touch /home/darkarmy1/.hushlogin
RUN touch /home/darkarmy2/.hushlogin
RUN touch /home/darkarmy3/.hushlogin

# Level 0
RUN echo 'echo "Welcome to Spaidy lab"' >> /home/darkarmy0/.bashrc \
    && echo 'echo "dark_flag{7c945bc1393bd504aad1}"' >> /home/darkarmy0/.bashrc \
    && echo 'exit' >> /home/darkarmy0/.bashrc \
    && chown -R darkarmy0:darkarmy0 /home/darkarmy0

# Level 1
RUN mkdir -p /home/darkarmy1/dungeon \
    && mkdir -p /home/darkarmy1/lair/trap \
    && mkdir -p /home/darkarmy1/cave

RUN touch "/home/darkarmy1/FLAG{LOGIN_SUCCESS}" \
    && echo "Don't forget to feed the dragon!" > /home/darkarmy1/notes.txt \
    && echo "Last seen flying over sector 7..." > /home/darkarmy1/dragon.log \
    && echo "FLAG{dragon_approved_shell}" > "/home/darkarmy1/dungeon/FLAG{dungeon_found}" \
    && echo "RkxBR3tkcmFnb25fYXBwcm92ZWRfc2hlbGx9" > "/home/darkarmy1/lair/scroll.md" \
    && echo "464c41477b647261676f6e5f617070726f7665645f7368656c6c7d" > "/home/darkarmy1/lair/trap/hex.flag" \
    && echo "IJQWQYLUMEQGS4ZAMEQW45DJNZ2W45DFOJUXGZJA" > "/home/darkarmy1/cave/base32.flag" \
    && echo "This is not the flag you're looking for." > "/home/darkarmy1/fake_flag.txt" \
    && chown -R darkarmy1:darkarmy1 /home/darkarmy1

# Level 2
RUN mkdir -p /home/darkarmy2/.hidden_folder
RUN echo "dark_flag{ad8ec66dc93c9b0a84ae}" > /home/darkarmy2/.hidden_folder/flag.txt

# Level 3
RUN echo "echo 'Decrypt it with aes-256-cbc algorithm, the password is darkavengars: U2FsdGVkX18BY+S7hDZboK3+Qs31itEJ1sPLMx7UBAP6huEBIsoz010CocRr96NFbl/3hbJErjdKg/I75+ZGYg=='" >> /home/darkarmy3/.bashrc

COPY ./nullsafety /usr/bin/nullsafety
RUN chmod +x /usr/bin/nullsafety

RUN chsh -s /usr/bin/bash darkarmy0
RUN chsh -s /usr/bin/nullsafety darkarmy1
RUN chsh -s /usr/bin/nullsafety darkarmy2
RUN chsh -s /usr/bin/nullsafety darkarmy3

# Expose SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
